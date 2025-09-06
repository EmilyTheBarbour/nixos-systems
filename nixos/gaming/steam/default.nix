{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  }; 

  # allows certain AppImage released games to run via steam sandboxing
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}