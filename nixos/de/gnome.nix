{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.udev.packages = with pkgs; [
    gnome.gnome-settings-daemon
  ];
  
  environment.gnome.excludePackages = with pkgs.gnome; with pkgs; [
    epiphany
    simple-scan
    totem
    yelp
    evince
    geary
    gnome-contacts
    gnome-logs
    gnome-maps
    gnome-music
    gnome-connections
    gnome-console
  ];

  # we'll be using the HomeManager module for configuration
  # so lets append to the home-manager modules for this system
  home-manager.users.${flake.config.people.myself} = {
    imports = [
      ../../home/de/gnome.nix
    ];
  };
}
