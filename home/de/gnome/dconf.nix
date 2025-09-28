# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/mutter" = {
      edge-tiling = false;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [];
      toggle-tiled-right = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "ghostty";
      name = "ghostty";
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
  };
}
