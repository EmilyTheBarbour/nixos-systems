{ pkgs, lib, ... }: {
  imports = [ ./gnome ];

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
}
