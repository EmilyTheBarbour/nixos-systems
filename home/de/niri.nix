{
  pkgs,
  lib,
  config,
  ...
}: {
  # wallpaper
  services.swww.enable = true;

  # Notifications
  services.mako.enable = true;

  # Application Manager
  programs.fuzzel.enable = true;

  programs.ghostty = {
    settings = {
      window-decoration = "none";
    };
  };

  gtk.gtk4.theme = config.gtk.theme;

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.macchiatoDark;
    name = "catppuccin-macchiato-dark-cursors";
    size = 4;
  };

  # Waybar
  # programs.waybar.enable = true;
  # programs.waybar.systemd.enable = true;
  # programs.waybar.systemd.target = "niri.service";
  # TODO(emily): Find my own and decompose
  home.file.".config/waybar/config".source = ../../config/niri/waybar.conf;
  home.file.".config/waybar/style.css".source = ../../config/niri/waybar.css;

  # Niri
  # TODO(emily): FInd my own and decompose
  xdg.configFile."niri/config.kdl".source = ../../config/niri/config.kdl;

  # Swaylock
  xdg.configFile."swaylock/config".source = ../../config/niri/swaylock.conf;
}
