{ pkgs, ... }: {
  home.packages = with pkgs; [
    linux-wallpaperengine
  ];

  # systemd.user.services.wallpaper-engine = {
  #   Unit = {
  #     Description = "Automatically run wallpaper-engine wallpaper of choice on log-in";
  #   };
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  #   Service = { ExecStart = "${pkgs.getExe pkgs.linux-wallpaperengine}" };
  # };
}
