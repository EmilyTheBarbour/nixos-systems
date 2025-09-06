{ pkgs, lib, config, ... }: {
  options = {
    wallpaper-id = lib.mkOption {
      type = lib.types.int;
      default = 123123123123;
    };
  };

  config = {
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
    #   Service = { ExecStart = "${pkgs.getExe pkgs.linux-wallpaperengine} --silent ${config.wallpaper-id}" };
    # };
  };

}
