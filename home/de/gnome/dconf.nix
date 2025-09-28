# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/Extensions" = {
      window-height = 1040;
      window-maximized = false;
      window-width = 628;
    };

    # "org/gnome/Weather" = {
    #   locations = [ (mkVariant [ (mkUint32 2) (mkVariant [ "Seattle" "KBFI" true [ (mkTuple [ 0.8298313314533731 (-2.134775231953554) ]) ] [ (mkTuple [ 0.8308850914425572 (-2.135097419733472) ]) ] ]) ]) ];
    #   window-height = 494;
    #   window-maximized = false;
    #   window-width = 587;
    # };

    "org/gnome/baobab/ui" = {
      is-maximized = false;
      window-size = mkTuple [ 960 600 ];
    };

    # "org/gnome/clocks" = {
    #   world-clocks = [ {
    #     location = mkVariant [ (mkUint32 2) (mkVariant [ "Seattle" "KBFI" true [ (mkTuple [ 0.8298313314533731 (-2.134775231953554) ]) ] [ (mkTuple [ 0.8308850914425572 (-2.135097419733472) ]) ] ]) ];
    #   } {
    #     location = mkVariant [ (mkUint32 2) (mkVariant [ "Atlanta" "KATL" true [ (mkTuple [ 0.5871336123862131 (-1.4735281501968716) ]) ] [ (mkTuple [ 0.5890310819891037 (-1.4728481350137095) ]) ] ]) ];
    #   } ];
    # };

    "org/gnome/clocks/state/window" = {
      maximized = false;
      panel-id = "world";
      size = mkTuple [ 870 690 ];
    };

    "org/gnome/control-center" = {
      last-panel = "system";
      window-state = mkTuple [ 980 640 true ];
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "Utilities" "YaST" "Pardus" ];
    };

    "org/gnome/desktop/app-folders/folders/Pardus" = {
      categories = [ "X-Pardus-Apps" ];
      name = "X-Pardus-Apps.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.Loupe.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop" ];
      categories = [ "X-GNOME-Utilities" ];
      name = "X-GNOME-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///nix/store/665j0l3v04az3mhmcxrnddyvxnbxg8lq-wallpaper.jpg";
      picture-uri-dark = "file:///nix/store/665j0l3v04az3mhmcxrnddyvxnbxg8lq-wallpaper.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" "lv3:ralt_switch" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "org-gnome-console" "org-gnome-characters" "gnome-power-panel" "org-gnome-settings" "discord" "org-gnome-baobab" "firefox" "org-gnome-nautilus" "osu-" "org-prismlauncher-prismlauncher" ];
    };

    "org/gnome/desktop/notifications/application/discord" = {
      application-id = "discord.desktop";
    };

    "org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-baobab" = {
      application-id = "org.gnome.baobab.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-characters" = {
      application-id = "org.gnome.Characters.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-console" = {
      application-id = "org.gnome.Console.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
      application-id = "org.gnome.Nautilus.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-settings" = {
      application-id = "org.gnome.Settings.desktop";
    };

    "org/gnome/desktop/notifications/application/org-prismlauncher-prismlauncher" = {
      application-id = "org.prismlauncher.PrismLauncher.desktop";
    };

    "org/gnome/desktop/notifications/application/osu-" = {
      application-id = "osu!.desktop";
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      acceleration-profile = "flat";
      speed = 0.25;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/privacy" = {
      old-files-age = mkUint32 30;
      recent-files-max-age = -1;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/emily/.local/share/backgrounds/2025-09-27-22-18-59-wallpaper.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/search-providers" = {
      disabled = [ "org.gnome.Characters.desktop" ];
      sort-order = [ "org.gnome.Contacts.desktop" "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" ];
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 300;
    };

    "org/gnome/desktop/wm/keybindings" = {
      maximize = [];
      unmaximize = [];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    "org/gnome/epiphany" = {
      ask-for-default = false;
    };

    "org/gnome/epiphany/state" = {
      is-maximized = true;
      window-size = mkTuple [ 1920 1048 ];
    };

    "org/gnome/evince/default" = {
      continuous = true;
      dual-page = false;
      dual-page-odd-left = true;
      enable-spellchecking = true;
      fullscreen = false;
      inverted-colors = false;
      show-sidebar = true;
      sidebar-page = "thumbnails";
      sidebar-size = 132;
      sizing-mode = "automatic";
      window-ratio = mkTuple [ 0.980392 0.757576 ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/file-roller/listing" = {
      list-mode = "as-folder";
      name-column-width = 67;
      show-path = false;
      sort-method = "name";
      sort-type = "ascending";
    };

    "org/gnome/file-roller/ui" = {
      sidebar-width = 200;
      window-height = 480;
      window-width = 600;
    };

    "org/gnome/gnome-system-monitor" = {
      cpu-colors = [ (mkTuple [ (mkUint32 0) "#e01b24" ]) (mkTuple [ 1 "#ff7800" ]) (mkTuple [ 2 "#f6d32d" ]) (mkTuple [ 3 "#33d17a" ]) (mkTuple [ 4 "#26a269" ]) (mkTuple [ 5 "#62a0ea" ]) (mkTuple [ 6 "#1c71d8" ]) (mkTuple [ 7 "#613583" ]) (mkTuple [ 8 "#9141ac" ]) (mkTuple [ 9 "#c061cb" ]) (mkTuple [ 10 "#ffbe6f" ]) (mkTuple [ 11 "#f9f06b" ]) (mkTuple [ 12 "#8ff0a4" ]) (mkTuple [ 13 "#2ec27e" ]) (mkTuple [ 14 "#1a5fb4" ]) (mkTuple [ 15 "#c061cb" ]) (mkTuple [ 16 "#f3327999b00c" ]) (mkTuple [ 17 "#7999d388f332" ]) (mkTuple [ 18 "#f332ef607999" ]) (mkTuple [ 19 "#cbe57999f332" ]) (mkTuple [ 20 "#7999f332a86a" ]) (mkTuple [ 21 "#f33284ee7999" ]) (mkTuple [ 22 "#799991bef332" ]) (mkTuple [ 23 "#b53af3327999" ]) ];
      maximized = false;
      show-dependencies = false;
      show-whose-processes = "user";
      window-height = 720;
      window-width = 800;
    };

    "org/gnome/gnome-system-monitor/proctree" = {
      col-26-visible = false;
      col-26-width = 0;
    };

    "org/gnome/mutter" = {
      edge-tiling = false;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [];
      toggle-tiled-right = [];
    };

    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "large";
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 890 550 ];
      initial-size-file-chooser = mkTuple [ 890 550 ];
      maximized = true;
    };

    "org/gnome/portal/filechooser/obsidian" = {
      last-folder-path = "/home/emily/Documents/robotics";
    };

    "org/gnome/portal/filechooser/org/gnome/Settings" = {
      last-folder-path = "/home/emily/config/config";
    };

    "org/gnome/screensaver" = {
      picture-uri = "file:///nix/store/dfcg0iili1sg14mlvkxinzvixd6166sh-lockscreen.jpg";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "terminator";
      name = "Terminator";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "Print";
      command = "script --command \"flameshot gui\" /dev/null";
      name = "Flameshot";
    };

    "org/gnome/shell" = {
      command-history = [ "r" ];
      disable-user-extensions = false;
      disabled-extensions = [ "apps-menu@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [ "dash-to-dock@micxgx.gmail.com" "Bluetooth-Battery-Meter@maniacx.github.com" "burn-my-windows@schneegans.github.com" "compiz-windows-effect@hermes83.github.com" "pano@elhan.io" "tilingshell@ferrarodomenico.com" "Vitals@CoreCoding.com" "appindicatorsupport@rgcjonas.gmail.com" "blur-my-shell@aunetx" ];
      favorite-apps = [ "firefox.desktop" "codium.desktop" "terminator.desktop" "steam.desktop" "net.lutris.Lutris.desktop" "discord.desktop" ];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "46.2";
    };

    "org/gnome/shell/extensions/Bluetooth-Battery-Meter" = {
      color-10 = "#ff7800";
      color-100 = "#15c931";
      color-20 = "#ff7800";
      color-30 = "#15c931";
      color-40 = "#15c931";
      color-50 = "#15c931";
      color-60 = "#15c931";
      color-70 = "#15c931";
      color-80 = "#15c931";
      color-90 = "#15c931";
      device-list = [ ''
        {"path":"/org/bluez/hci0/dev_88_C9_E8_13_E2_6C","icon":"audio-headset","alias":"WH-1000XM5","paired":true,"battery-reported":false,"qs-level":false,"indicator-mode":0,"connected-time":1759034192,"disconnected-time":1759034192}\n
      '' ];
      enable-battery-level-text = false;
      swap-icon-text = false;
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-brightness = 0.0;
      icon-contrast = 0.0;
      icon-opacity = 240;
      icon-saturation = 0.0;
      icon-size = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;
      blur-on-overview = true;
      brightness = 1.0;
      dynamic-opacity = false;
      enable-all = true;
      opacity = 233;
      sigma = 58;
    };

    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      pipeline = "pipeline_default_rounded";
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/hidetopbar" = {
      compatibility = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      pipeline = "pipeline_default";
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/burn-my-windows" = {
      active-profile = "/home/emily/.config/burn-my-windows/profiles/1759034194472370.conf";
      last-extension-version = 46;
      last-prefs-version = 46;
      prefs-open-count = 3;
      preview-effect = "";
    };

    "org/gnome/shell/extensions/com/github/hermes83/compiz-windows-effect" = {
      friction = 5.6;
      resize-effect = false;
      speedup-factor-divider = 19.7;
      spring-k = 7.5;
    };

    "org/gnome/shell/extensions/pano" = {
      keep-search-entry = true;
      play-audio-on-copy = false;
      send-notification-on-copy = false;
      show-indicator = true;
    };

    "org/gnome/shell/extensions/tilingshell" = {
      enable-blur-selected-tilepreview = true;
      enable-blur-snap-assistant = true;
      enable-window-border = false;
      inner-gaps = mkUint32 4;
      last-version-name-installed = "16.4";
      layouts-json = "[{\"id\":\"Layout 1\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.22,\"height\":0.5,\"groups\":[1,2]},{\"x\":0,\"y\":0.5,\"width\":0.22,\"height\":0.5,\"groups\":[1,2]},{\"x\":0.22,\"y\":0,\"width\":0.56,\"height\":1,\"groups\":[2,3]},{\"x\":0.78,\"y\":0,\"width\":0.22,\"height\":0.5,\"groups\":[3,4]},{\"x\":0.78,\"y\":0.5,\"width\":0.22,\"height\":0.5,\"groups\":[3,4]}]},{\"id\":\"Layout 2\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[1]},{\"x\":0.22,\"y\":0,\"width\":0.56,\"height\":1,\"groups\":[1,2]},{\"x\":0.78,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[2]}]},{\"id\":\"Layout 3\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]},{\"x\":0.33,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]}]},{\"id\":\"Layout 4\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]},{\"x\":0.67,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]}]}]";
      outer-gaps = mkUint32 4;
      overridden-settings = "{\"org.gnome.mutter.keybindings\":{\"toggle-tiled-right\":\"['<Super>Right']\",\"toggle-tiled-left\":\"['<Super>Left']\"},\"org.gnome.desktop.wm.keybindings\":{\"maximize\":\"['<Super>Up']\",\"unmaximize\":\"['<Super>Down', '<Alt>F5']\"},\"org.gnome.mutter\":{\"edge-tiling\":\"true\"}}";
      selected-layouts = [ [ "Layout 1" "Layout 1" ] [ "Layout 1" "Layout 1" ] ];
      show-indicator = true;
    };

    "org/gnome/shell/extensions/vitals" = {
      alphabetize = true;
      fixed-widths = true;
      hide-icons = false;
      hide-zeros = false;
      icon-style = 1;
      menu-centered = false;
      position-in-panel = 0;
      show-battery = true;
      show-gpu = true;
      use-higher-precision = false;
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [];
    };

    # "org/gnome/shell/weather" = {
    #   automatic-location = true;
    #   locations = [ (mkVariant [ (mkUint32 2) (mkVariant [ "Seattle" "KBFI" true [ (mkTuple [ 0.8298313314533731 (-2.134775231953554) ]) ] [ (mkTuple [ 0.8308850914425572 (-2.135097419733472) ]) ] ]) ]) ];
    # };

    # "org/gnome/shell/world-clocks" = {
    #   locations = [ (mkVariant [ (mkUint32 2) (mkVariant [ "Seattle" "KBFI" true [ (mkTuple [ 0.8298313314533731 (-2.134775231953554) ]) ] [ (mkTuple [ 0.8308850914425572 (-2.135097419733472) ]) ] ]) ]) (mkVariant [ (mkUint32 2) (mkVariant [ "Atlanta" "KATL" true [ (mkTuple [ 0.5871336123862131 (-1.4735281501968716) ]) ] [ (mkTuple [ 0.5890310819891037 (-1.4728481350137095) ]) ] ]) ]) ];
    # };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      sidebar-width = 140;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      view-type = "list";
      window-size = mkTuple [ 859 366 ];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 167;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 26 23 ];
      window-size = mkTuple [ 1231 902 ];
    };

  };
}
