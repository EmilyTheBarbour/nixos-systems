# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ config, lib, ... }: (lib.mkIf (config.de.type == "gnome") {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "terminator";
      name = "Terminator";
    };
  };
})
