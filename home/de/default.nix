{
  parameters,
  lib,
  ...
}: let
  # custom bypasses the machinery and lets you define your own
  deMapping = {
    gnome = lib.trace "enabling gnome support in home-manager" ./gnome;
  };
in {
  imports =
    if builtins.hasAttr parameters.de.type deMapping
    then [(lib.getAttr parameters.de.type deMapping)]
    else [];
}
