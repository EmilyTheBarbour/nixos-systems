{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamemode.enable = true;

  # allows certain AppImage released games to run via steam sandboxing
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
