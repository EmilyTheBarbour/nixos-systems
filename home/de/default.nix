{
  parameters,
  lib,
  ...
}: let
  # custom bypasses the machinery and lets you define your own
  deMapping = {
    gnome = lib.trace "enabling gnome support in home-manager" ./gnome;
    cosmic = lib.trace "enabling cosmic support in home-manager" ./cosmic.nix;
  };
in {
  imports =
    if builtins.hasAttr parameters.de.type deMapping
    then [(lib.getAttr parameters.de.type deMapping)]
    else [];
}
