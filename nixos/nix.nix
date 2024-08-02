{ flake, pkgs, ...}:
let 
  inherit (flake) inputs;
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;  
    };
    overlays = [
      (import ../packages/overlay.nix {inherit flake; inherit (pkgs) system; })
      inputs.nixgl.overlay
      inputs.nix-vscode-extensions.overlays.default
    ];
  };
  
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}