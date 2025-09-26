import os
import re
import json 
import pathlib
import sys

class Flags:
    def __init__(self) -> None:
        self._add = []
        self._remove = []
        
    def push_add_flag(self, add_flag):
        if not self._is_flag_already_added(add_flag, self._add):
            self._add.append(add_flag)
        
    def push_remove_flag(self, remove_flag):
        if not self._is_flag_already_added(remove_flag, self._remove):
            self._remove.append(remove_flag)
        
        
    def generate_clangd_file(self, stream):
        _clangd_dict = {
            "CompileFlags": {
                "Add" : self._add, 
                "Remove" : self._remove
            }
        }
        
        json.dump(_clangd_dict, stream, indent=2)
        
        
    
    def _is_flag_already_added(self, flag, ds):
        # do the naieve exact string compare
        if flag in ds:
            return True
        
        # fallback if we have hashes
        search = re.compile(r'\/nix\/store\/([a-z0-9]{32})-')
        maybe_flag_hash = search.findall(flag)
        
        if len(maybe_flag_hash) != 0:
            flag_hash = maybe_flag_hash[0]

            curr_hashes = []
            for val in ds:
                maybe_hash = search.findall(val)
                if len(maybe_hash) != 0:
                    curr_hashes.append(maybe_hash[0])

            if flag_hash in curr_hashes:
                return True 
            
        # didn't find it using any of our metrics
        return False

INCLUDE_PATH_ENV_VARS = ["CMAKE_INCLUDE_PATH"]
INCLUDE_FOLDERS = ["pub", "include", "interface"]
EXCLUDE_FOLDERS = [".git", 'build', 'outputs', '.direnv']
MANUAL_FLAGS_REL_PATH = ".clangd-extra"

flags = {
    "add": [],
    "remove" : []
}

def main():
    flags = Flags()
    
    root_dir = (sys.argv[1] if len(sys.argv) >= 2 else os.getcwd())
    print(f"using root directory {root_dir}")
    
    num_added = 0
    print("searching for child include folders... ", end="")
    for root, dirs, files in os.walk(root_dir, followlinks=False):
        dirs[:] = [d for d in dirs if d not in EXCLUDE_FOLDERS]
        for name in dirs:
            if name in INCLUDE_FOLDERS:
                flags.push_add_flag(f"-I{pathlib.Path(os.path.join(root, name)).resolve()}")
                
                # don't recurse down this path anymore
                dirs.remove(name)
                
    print(f"{len(flags._add) - num_added} found.")
    num_added = len(flags._add)
    
    print("adding dependencies noted in env vars... ", end="")
    for env_var in INCLUDE_PATH_ENV_VARS:
        env_flags = [
            f'-I{x.strip()}'
            for x
            in re.split(',|:| ', os.environ.get(env_var, "")) 
            if x.strip() != ""
        ]
        
        for flag in env_flags:
            flags.push_add_flag(flag)
    print(f"{len(flags._add) - num_added} found.")
    num_added = len(flags._add)

    manual_flags_path = os.path.join(root_dir, MANUAL_FLAGS_REL_PATH)
    print(f"searching for additional manual flags defined in {manual_flags_path}... ", end="")
    if(os.path.exists(manual_flags_path)):
        print("found!")
        
        with open(manual_flags_path, 'r') as f:
            manual_flags = json.load(f)
            
            for add in manual_flags['add']:
                flags.push_add_flag(add)

            for remove in manual_flags['remove']:
                flags.push_remove_flag(remove)
    else:
        print("file not found!")
    
    print("generating resultant clangd file")
    with open(os.path.join(root_dir, '.clangd'), 'w') as f:
        flags.generate_clangd_file(f)

if __name__ == "__main__":
    main()