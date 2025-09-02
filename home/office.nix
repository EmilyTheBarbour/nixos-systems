{pkgs, ...}: {
  # todo(emily): move to personal-config
  home.packages = with pkgs; [
    libreoffice-qt6-fresh
  ];
}
