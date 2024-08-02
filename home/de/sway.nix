{ flake, config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    swaylock
    swayidle
    wl-clipboard
    mako
    alacritty
    wofi
    waybar
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      terminal = "alacritty";
      menu = "wofi --show run";
      bars = [{
        fonts.size = 15.0;
        command = "waybar";
        position = "bottom";
      }];

      output = {
        DP-1 = {
          scale = "1";
        };
        DP-2 = {
          scale = "1";
        };
      };
    };
  };
}
