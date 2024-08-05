{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (import ../packages/overlay.nix { inherit flake; inherit (pkgs) system; })
      inputs.nixgl.overlay
      inputs.nix-vscode-extensions.overlays.default
      inputs.nur.overlay
    ];
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.trusted-users = [ "root" "${flake.config.people.myself}" ];
    optimise.automatic = true;
  };
}
