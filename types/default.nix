{...} @ args: let
  # List of all of the files defining our types
  files = [
    (import ./user.nix)
    (import ./de.nix)
    (import ./machine.nix)
  ];
in
  # Convert into a singular flat attrSet that can be overlayed on top of nixpkgs.lib.types
  builtins.foldl' (a: b: a // b) {} (
    # For each file, call it with the args provided above
    builtins.map (x: x args) files
  )
