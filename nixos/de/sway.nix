{ pkgs, ... }:

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
}
