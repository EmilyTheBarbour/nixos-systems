{pkgs, ...}: {
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    udev.packages = with pkgs; [gnome-settings-daemon];
  };

  # TODO(emily): Make these config options to go with home-manager configs
  environment.systemPackages = with with pkgs; gnomeExtensions; [
    appindicator
    bluetooth-battery-meter
    pano
    burn-my-windows
    compiz-windows-effect
    vitals
    tiling-shell
    blur-my-shell
  ];

  programs.dconf.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    atomix # puzzle game
    epiphany # web browser
    geary # email reader
    gedit # text editor
    gnome-music
    gnome-terminal
    gnome-tour
    hitori # sudoku game
    iagno # go game
    tali # poker game
  ];
}
