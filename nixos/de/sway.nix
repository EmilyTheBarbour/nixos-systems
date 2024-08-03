{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in

{
  security.polkit.enable = true;

  security.pam.services.swaylock = {
    text = "auth include login";
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
  };

  # we'll be using the HomeManager module for configuration
  # so lets append to the home-manager modules for this system
  home-manager.users.${flake.config.people.myself} = {
    imports = [
      ../../home/de/sway.nix
    ];
  };
}
