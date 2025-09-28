{
  imports = [
    ./burn-my-windows.nix
    ./bluetooth-battery.nix
    ./blur-my-shell.nix
    ./compiz-windows.nix
    ./pano.nix
    ./tilingshell.nix
    ./vitals.nix
    ./appindicator.nix
  ];

  config = {
    dconf.settings = {
      "org/gnome/shell" = {
        command-history = ["r"];
        disable-user-extensions = false;
        disabled-extensions = ["apps-menu@gnome-shell-extensions.gcampax.github.com"];
        enabled-extensions = ["dash-to-dock@micxgx.gmail.com" "Bluetooth-Battery-Meter@maniacx.github.com" "burn-my-windows@schneegans.github.com" "compiz-windows-effect@hermes83.github.com" "pano@elhan.io" "tilingshell@ferrarodomenico.com" "Vitals@CoreCoding.com" "appindicatorsupport@rgcjonas.gmail.com" "blur-my-shell@aunetx"];
        favorite-apps = ["firefox.desktop" "codium.desktop" "terminator.desktop" "steam.desktop" "net.lutris.Lutris.desktop" "discord.desktop"];
        last-selected-power-profile = "performance";
        welcome-dialog-last-shown-version = "46.2";
      };
    };
  };
}
