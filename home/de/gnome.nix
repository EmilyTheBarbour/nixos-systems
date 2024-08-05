{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
  ];

  dconf = {
    enable = true;

    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          dash-to-dock.extensionUuid
          appindicator.extensionUuid
        ];

        favorite-apps = [ "firefox.desktop" "terminator.desktop" "code.nix" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Alt>t";
        command = "kitty";
        name = "Launch Console";
      };

      "org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
  };

}
