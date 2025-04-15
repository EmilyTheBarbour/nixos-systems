{pkgs, ...}:

{
  home.packages = with pkgs; [
    kdenlive
    vlc
  ];

  programs.obs-studio.enable = true;
}