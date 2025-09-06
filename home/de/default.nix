{
  parameters,
  lib,
  ...
}: let
  # custom bypasses the machinery and lets you define your own
  deMapping = {
    gnome = ./gnome;
  };
in {
  imports =
    if builtins.hasAttr parameters.de.type deMapping
    then [(lib.getAttr parameters.de.type deMapping)]
    else [];
}
