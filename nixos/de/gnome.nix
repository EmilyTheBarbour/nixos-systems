{pkgs, ...}: {
  services = {
    # TODO(Emily): Investigate switching to full wayland. as of 25.11, GNOME On nixOS has deprecated x11 support but
    # this currently applies a backwards compatibility via xWayland
    xserver.enable = true;

    # Even more basic using gnome, but honestly it has the best motion gestures for laptops in the NIX ecosystem IMO.
    # I should eventually move this into a more full-fledged module, but practically all my dconf settings are
    # home-manager configured ATM anyways so /shrug
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    udev.packages = with pkgs; [gnome-settings-daemon];
  };

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

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
