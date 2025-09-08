{pkgs, ...}: {
  services = {
    xserver.enable = true;

    # Even more basic using gnome, but honestly it has the best motion gestures for laptops in the NIX ecosystem IMO.
    # I should eventually move this into a more full-fledged module, but practically all my dconf settings are
    # home-manager configured ATM anyways so /shrug
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    udev.packages = with pkgs; [gnome-settings-daemon];
  };

  environment.systemPackages = with pkgs; [gnomeExtensions.appindicator];

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
