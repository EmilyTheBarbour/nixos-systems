{ parameters, lib, ... }:
let
  # custom bypasses the machinery and lets you define your own
  deMapping = {
    gnome = ./gnome;
  };
in
{
  imports = (if deMapping ? parameter.de.type then [ (lib.getAttr parameters.de.type deMapping) ] else [ ]);
}
