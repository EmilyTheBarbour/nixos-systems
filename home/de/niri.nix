{
  pkgs,
  lib,
  config,
  ...
}: {
  # catppuccin.enable = lib.mkForce false;

  # Graphics Library Configs
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
    colorScheme = "dark";

    # TODO(emily): Deprecated in 26.05
    gtk4.theme = config.gtk.theme;
  };
  qt = {
    enable = true;
    style.name = "kvantum";
  };
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.macchiatoDark;
    name = "catppuccin-macchiato-dark-cursors";
    size = 6;
  };

  # wallpaper
  services.swww.enable = true;

  # Notifications
  services.swaync.enable = true;

  # Program Launcher
  programs.wofi = {
    enable = true;
    settings = {
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 30;
      allow_markup = true;
      width = 400;
      term = "ghostty";
      dmenu-parse_action = true;
    };
    style = ''
      window {
      margin: 0px;
      border: 1px solid #005bf8ff;
      background-color: #282a36;
      }

      #input {
      margin: 5px;
      border: none;
      color: #f8f8f2;
      background-color: #44475a;
      }

      #inner-box {
      margin: 5px;
      border: none;
      background-color: #282a36;
      }

      #outer-box {
      margin: 5px;
      border: none;
      background-color: #282a36;
      }

      #scroll {
      margin: 0px;
      border: none;
      }

      #text {
      margin: 5px;
      border: none;
      color: #f8f8f2;
      }

      #entry.activatable #text {
      color: #282a36;
      }

      #entry > * {
      color: #f8f8f2;
      }

      #entry:selected {
      background-color: #44475a;
      }

      #entry:selected #text {
      font-weight: bold;
      }

    '';
  };

  programs.ghostty = {
    settings = {
      window-decoration = "none";
    };
  };

  home.file.".config/waybar/config".source = ../../config/niri/waybar.conf;
  home.file.".config/waybar/style.css".source = ../../config/niri/waybar.css;

  xdg.configFile."niri/config.kdl".source = ../../config/niri/config.kdl;
  xdg.configFile."swaylock/config".source = ../../config/niri/swaylock.conf;
  home.file.".local/bin/nws.sh".source = ../../config/niri/nws.sh;
}
