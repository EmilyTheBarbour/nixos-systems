{
  config,
  pkgs,
  ...
}: {
  home.username = "ebarbour";
  home.homeDirectory = "/home/ebarbour";

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
