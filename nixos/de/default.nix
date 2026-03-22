{
  lib,
  parameters,
  ...
}: let
  # custom bypasses the machinery and lets you define your own
  deMapping = {
    gnome = lib.trace "enabling gnome support in nixOS" ./gnome.nix;
    cosmic = lib.trace "enabling cosmic support in nixOS" ./cosmic.nix;
    niri = lib.trace "enabling niri support in nixOS" ./niri.nix;
  };
in {
  imports =
    if builtins.hasAttr parameters.de.type deMapping
    then [(lib.getAttr parameters.de.type deMapping)]
    else [];
}
