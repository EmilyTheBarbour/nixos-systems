{
  pkgs,
  lib,
  ...
}: {
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  programs.nix-ld.enable = true;

  # catppuccin.enable = lib.mkForce false;

  # Niri is very unopinionated, roll your own environment
  # so we need to manually specify everything we want here :)
  # We'll start simple with GNOME display manager :)
  services.displayManager.enable = true;
  services.displayManager.ly = {
    enable = true;
  };

  security.polkit.enable = true;

  xdg.portal.wlr.enable = true;

  environment.variables = {
    # LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };

  environment.systemPackages = with pkgs; [
    waybar-mpris
    playerctl
    waypaper
    mpvpaper
    waybar
    swaylock-effects
    swayidle
    swaynotificationcenter
    wget
    wl-clipboard-rs
    steam-run
    wlogout
    adw-gtk3
    papirus-icon-theme
    nautilus
    pavucontrol
    btop

    xwayland-satellite
  ];
}
