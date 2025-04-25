{pkgs, ...}: {
  home.packages = with pkgs; [
    kdePackages.kdenlive
    vlc
  ];

  programs.obs-studio.enable = true;
}
