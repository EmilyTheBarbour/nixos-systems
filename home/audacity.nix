{pkgs, ...}: {
  home.packages = with pkgs; [
    audacity-4
  ];
}