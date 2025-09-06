lib: let
  inherit (lib) types mkOption mkDefault mkEnableOption;
in
  types.submodule ({config, ...}: {
    options = {
      de.type = mkOption {
        type = types.enum ["gnome" "custom"];
      };

      # TODO(emily): Instrument for multi-user machines
      users = {
        main-user = {
          user-name = mkOption {
            type = types.str;
          };

          display-name = mkOption {
            type = types.str;
          };
        };
      };

      machine = {
        name = mkOption {
          type = types.str;
        };

        system = mkOption {
          type = types.str;
        };

        type = mkOption {
          type = types.enum [
            "dell-precision-5690"

            # Initially configured via my personal PC
            "generic-desktop-x86"

            # user consents to having a special machine that hasn't been integrated
            # with yet, and that they will maintain that specifically for themselves
            "custom"
          ];
        };

        state-version = mkOption {
          type = types.str;
        };
      };

      modules = mkOption {
        # TODO(emily): figure out the semantics for taking in a list of modules
        type = types.listOf types.anything;
      };

      gaming = {
        enable = mkEnableOption "whether or not to install gaming related services on the machine";
      };
    };

    # This is the easiest way to make composable default configuration
    config = {
      de.type = mkDefault "gnome";

      machine.type = mkDefault "generic-desktop-x86";
      machine.system = mkDefault "x86_64-linux";
      machine.state-version = "24.11";

      users.main-user = {
        user-name = mkDefault "emily";
        display-name = mkDefault "Emily Barbour";
      };

      modules = mkDefault [];

      gaming.enable = mkDefault true;
    };
  })
