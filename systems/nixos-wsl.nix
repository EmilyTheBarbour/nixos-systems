{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    # biggest thing is to use our WSL module
    inputs.nixos-wsl.nixosModules.default
    
    # inherit the same modules we use for a normal nixOS system
    # TODO(emily): need to figure out how 1 to 1 this is for WSL
    self.nixosModules.default
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  nixos-flake.sshTarget = "emily@wsl-env";
  system.stateVersion = "24.05";
  
  # enable WSL support
  wsl = {
    enable = true;
  };
}