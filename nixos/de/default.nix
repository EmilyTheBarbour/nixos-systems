{ lib, config, ... }: {
  imports = [
    # x11 + gnome, simple as can be :)
    ./gnome.nix
  ];

  options =
    let
      deType = lib.types.enum [
        "gnome"

        "custom"
      ];

    in
    {
      de.type = lib.mkOption {
        description = "config to inherit for personal DE configs. use \"custom\" to exempt and control this yourself";
        type = deType;
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
