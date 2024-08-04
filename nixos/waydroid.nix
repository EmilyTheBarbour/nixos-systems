{ pkgs, ... }:

{
  virtualisation.waydroid.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    (makeDesktopItem {
      name = "cifi";
      desktopName = "CIFI";
      exec = "waydroid app launch com.OctocubeGamesCompany.CIFI";
    })
  ];
  
  
}
