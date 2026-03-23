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
  # xdg.configFile."niri/config.kdl".source = ../../config/niri/config.kdl;

  programs.niri.settings = {
    input = {
      keyboard = {
        xkb = {
          layout = "us";
        };
      };
      touchpad = {
        tap = true;
        natural-scroll = true;
      };
      mouse = {
        accel-profile = "flat";
      };
      warp-mouse-to-focus.enable = true;
    };
    overview = {
      zoom = 0.25;
    };

    layout = {
      gaps = 5;
      center-focused-column = "on-overflow";
      always-center-single-column = true;
      preset-column-widths = [
        {proportion = 1. / 3.;}
        {proportion = 1. / 2.;}
        {proportion = 2. / 3.;}
        {proportion = 4. / 5.;}
      ];
      default-column-width = {proportion = 4. / 5.;};
      focus-ring.width = lib.mkForce 2;
      shadow = {
        enable = true;
        draw-behind-window = true;
        softness = 50;
        spread = 5;
        offset = {
          x = 0;
          y = 5;
        };
      };
      background-color = "transparent";
    };

    hotkey-overlay.skip-at-startup = true;
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    window-rules = [
      {
        matches = [
          {title = "Picture in picture";}
        ];
        open-floating = true;
        default-floating-position = {
          x = 100;
          y = 100;
          relative-to = "bottom-right";
        };
        tiled-state = true;
      }
      {
        matches = [
          {app-id = "steam";}
        ];
        open-on-workspace = "oss";
      }
      {
        matches = [
          {app-id = "codium";}
        ];
        open-on-workspace = "code";
        opacity = 0.9;
        draw-border-with-background = false;
      }
      {
        matches = [
          {app-id = "^discord$";}
        ];
        open-on-workspace = "oss";
        opacity = 0.9;
        draw-border-with-background = false;
      }
      {
        matches = [
          {app-id = "firefox";}
        ];
        open-maximized = true;
        open-on-workspace = "brow";
      }
      {
        matches = [
          {app-id = "ghostty";}
        ];
        open-on-workspace = "term";
        opacity = 0.9;
        draw-border-with-background = false;
      }
      {
        geometry-corner-radius = {
          bottom-right = 6.;
          bottom-left = 6.;
          top-right = 6.;
          top-left = 6.;
        };
        clip-to-geometry = true;
      }
    ];

    outputs."ViewSonic Corporation XG2431 WEE221100395" = {
      mode = {
        height = 1080;
        width = 1920;
        refresh = 239.761;
      };
    };

    spawn-at-startup = [
      {argv = ["waybar"];}
      {argv = ["firefox"];}
      {argv = ["ghostty"];}
      {argv = ["codium"];}
      {argv = ["steam"];}

      {sh = "waypaper --random";}
      {sh = "swayidle -w timeout 600 'swaylock -f' timeout 900 'niri msg output power off' resume 'niri msg output power on' before-sleep 'swaylock -f'";}
    ];

    workspaces = {
      "1_main" = {name = "main";};
      "1_brow" = {name = "brow";};
      "1_term" = {name = "term";};
      "1_code" = {name = "code";};
      "1_oss" = {name = "oss";};
    };

    layer-rules = [
      {
        place-within-backdrop = true;
      }
    ];

    binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = [];

      "Mod+Shift+O" = {
        hotkey-overlay.title = "toggle opacity";
        action.toggle-window-rule-opacity = [];
      };

      "Mod+W" = {
        hotkey-overlay.title = "toggle waybar";
        repeat = false;
        action.spawn-sh = ["pkill -SIGUSR1 waybar || waybar"];
      };
      "Mod+T" = {
        hotkey-overlay.title = "Open a Terminal";
        action.spawn = "ghostty";
      };
      "Mod+B" = {
        hotkey-overlay.title = "Open a Browser";
        action.spawn = "firefox";
      };
      "Mod+O" = {
        hotkey-overlay.title = "Open a Obsidian";
        action. spawn = "obsidian";
      };
      "Mod+E" = {
        hotkey-overlay.title = "Open a FileManager";
        action. spawn = "nautilus";
      };
      "Mod+D" = {
        hotkey-overlay.title = "Run an Application";
        action. spawn-sh = "fuzzel";
      };
      "Super+Shift+L" = {
        hotkey-overlay.title = "Lock the Screen: swaylock";
        action. spawn-sh = "swaylock ";
      };

      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action. spawn-sh = ["wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"];
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn-sh = ["wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"];
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action. spawn-sh = ["wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"];
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action. spawn-sh = ["wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"];
      };
      "XF86AudioPlay" = {
        allow-when-locked = true;
        action. spawn-sh = ["playerctl play-pause"];
      };
      "XF86AudioNext" = {
        allow-when-locked = true;
        action. spawn-sh = ["playerctl next"];
      };
      "XF86AudioPrev" = {
        allow-when-locked = true;
        action. spawn-sh = ["playerctl previous"];
      };
      "XF86AudioStop" = {
        allow-when-locked = true;
        action. spawn-sh = ["playerctl stop"];
      };
      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action. spawn = ["brightnessctl" "--class=backlight" "set" "+10%"];
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action. spawn = ["brightnessctl" "--class=backlight" "set" "10%-"];
      };

      "Mod+TAB" = {
        repeat = false;
        action. toggle-overview = [];
      };
      "Mod+Q" = {
        repeat = false;
        action. close-window = [];
      };

      "Mod+Left".action .focus-column-left = [];
      "Mod+Down".action .focus-window-or-workspace-down = [];
      "Mod+Up".action   .focus-window-or-workspace-up = [];
      "Mod+Right".action.focus-column-right = [];
      "Mod+H".action    .focus-column-left = [];
      "Mod+L".action    .focus-column-right = [];

      "Mod+Ctrl+Left".action .move-column-left = [];
      "Mod+Ctrl+Down".action .move-window-down = [];
      "Mod+Ctrl+Up".action   .move-window-up = [];
      "Mod+Ctrl+Right".action.move-column-right = [];
      "Mod+Ctrl+H".action    .move-column-left = [];
      "Mod+Ctrl+L".action    .move-column-right = [];

      "Mod+J".action    .focus-window-or-workspace-down = [];
      "Mod+K".action    .focus-window-or-workspace-up = [];
      "Mod+Ctrl+J".action    .move-window-down-or-to-workspace-down = [];
      "Mod+Ctrl+K".action    .move-window-up-or-to-workspace-up = [];

      "Mod+Home".action.focus-column-first = [];
      "Mod+End".action .focus-column-last = [];
      "Mod+Ctrl+Home".action.move-column-to-first = [];
      "Mod+Ctrl+End".action .move-column-to-last = [];

      "Mod+Page_Down".action     .focus-workspace-down = [];
      "Mod+Page_Up".action       .focus-workspace-up = [];
      "Mod+U".action             .focus-workspace-down = [];
      "Mod+I".action             .focus-workspace-up = [];
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
      "Mod+Ctrl+Page_Up".action  .move-column-to-workspace-up = [];
      "Mod+Ctrl+U".action        .move-column-to-workspace-down = [];
      "Mod+Ctrl+I".action        .move-column-to-workspace-up = [];

      "Mod+Shift+Page_Down".action.move-workspace-down = [];
      "Mod+Shift+Page_Up".action  .move-workspace-up = [];
      "Mod+Shift+U".action        .move-workspace-down = [];
      "Mod+Shift+I".action        .move-workspace-up = [];

      "Mod+WheelScrollDown" = {
        cooldown-ms = 150;
        action. focus-workspace-down = [];
      };
      "Mod+WheelScrollUp" = {
        cooldown-ms = 150;
        action. focus-workspace-up = [];
      };
      "Mod+Ctrl+WheelScrollDown" = {
        cooldown-ms = 150;
        action. move-column-to-workspace-down = [];
      };
      "Mod+Ctrl+WheelScrollUp" = {
        cooldown-ms = 150;
        action. move-column-to-workspace-up = [];
      };

      "Mod+WheelScrollRight".action     .focus-column-right = [];
      "Mod+WheelScrollLeft".action      .focus-column-left = [];
      "Mod+Ctrl+WheelScrollRight".action.move-column-right = [];
      "Mod+Ctrl+WheelScrollLeft".action .move-column-left = [];

      "Mod+Shift+WheelScrollDown".action     .focus-column-right = [];
      "Mod+Shift+WheelScrollUp".action       .focus-column-left = [];
      "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [];
      "Mod+Ctrl+Shift+WheelScrollUp".action  .move-column-left = [];

      "Mod+TouchpadScrollDown".action . spawn-sh = ["wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02+"];
      "Mod+TouchpadScrollUp".action   . spawn-sh = ["wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02-"];

      "Mod+1".action . focus-workspace = 1;
      "Mod+2".action . focus-workspace = 2;
      "Mod+3".action . focus-workspace = 3;
      "Mod+4".action . focus-workspace = 4;
      "Mod+5".action . focus-workspace = 5;
      "Mod+6".action . focus-workspace = 6;
      "Mod+7".action . focus-workspace = 7;
      "Mod+8".action . focus-workspace = 8;
      "Mod+9".action . focus-workspace = 9;
      "Mod+Ctrl+1".action . move-column-to-workspace = 1;
      "Mod+Ctrl+2".action . move-column-to-workspace = 2;
      "Mod+Ctrl+3".action . move-column-to-workspace = 3;
      "Mod+Ctrl+4".action . move-column-to-workspace = 4;
      "Mod+Ctrl+5".action . move-column-to-workspace = 5;
      "Mod+Ctrl+6".action . move-column-to-workspace = 6;
      "Mod+Ctrl+7".action . move-column-to-workspace = 7;
      "Mod+Ctrl+8".action . move-column-to-workspace = 8;
      "Mod+Ctrl+9".action . move-column-to-workspace = 9;

      "Mod+BracketLeft".action  . consume-or-expel-window-left = [];
      "Mod+BracketRight".action . consume-or-expel-window-right = [];

      "Mod+Comma".action  . consume-window-into-column = [];
      "Mod+Period".action . expel-window-from-column = [];

      "Mod+R".action . switch-preset-column-width = [];
      "Mod+Shift+R".action . switch-preset-window-height = [];
      "Mod+Ctrl+R".action . reset-window-height = [];
      "Mod+F".action . maximize-column = [];
      "Mod+Shift+F".action . fullscreen-window = [];

      "Mod+Ctrl+F".action . expand-column-to-available-width = [];

      "Mod+C".action . center-column = [];

      "Mod+Ctrl+C".action . center-visible-columns = [];

      "Mod+Minus".action . set-column-width = "-25%";
      "Mod+Equal".action . set-column-width = "+25%";

      "Mod+Shift+Minus".action . set-window-height = "-25%";
      "Mod+Shift+Equal".action . set-window-height = "+25%";

      "Mod+V".action       . toggle-window-floating = [];
      "Mod+Shift+V".action . switch-focus-between-floating-and-tiling = [];

      "Mod+Shift+W".action . toggle-column-tabbed-display = [];

      "Print".action . screenshot = [];
      "Ctrl+Print".action . screenshot-screen = [];
      "Alt+Print".action . screenshot-window = [];

      "Mod+Escape".action   . spawn-sh = ["wlogout"];

      "Mod+Shift+E".action . quit = [];
      "Ctrl+Alt+Delete".action . quit = [];

      "Mod+Shift+P".action . power-off-monitors = [];
    };
  };

  # Swaylock
  xdg.configFile."swaylock/config".source = ../../config/niri/swaylock.conf;
}
