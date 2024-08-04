{ self, ... }:
{
  flake = {
    homeModules = {
      # All systems will shared these modules no matter what
      common = {
        home.stateVersion = "24.05";
        imports = [
          ./git.nix
          ./development.nix
          ./gdb.nix
        ];
      };

      # NixOS + Home-Manager enabled Linux distros only
      common-linux = {
        imports = [
          self.homeModules.common
          ./vscode.nix
          ./terminator.nix
          ./zsh.nix
          ./firefox.nix
          ./discord.nix
          ./video-editing.nix
          ./direnv.nix
          
          # the rest of the random programs I have 
          # enbabled but dont have dedicated modules for
          ./common.nix
        ];
      };

      # Darwin Only
      common-darwin = {
        imports = [
          self.homeModules.common
        ];
      };
    };
  };
}
