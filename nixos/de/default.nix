{ pkgs, lib, config, ... }: {
  imports = [
    # x11 + gnome, simple as can be :)
    ./gnome.nix
  ];

  options = {
    de.type = lib.mkOption {
      description = "config to inherit for personal DE configs. use \"custom\" to exempt and control this yourself";
      type = pkgs.lib.types.deType;
    };
  };

  config = {
    home-manager.users.${config.main-user.user-name} = {
      config = {
        de.type = config.de.type;
      };
    };
  };
}
