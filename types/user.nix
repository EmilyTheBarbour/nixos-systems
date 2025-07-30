lib: let
  inherit (lib) mkOption types;
in
  mkOption {
    description = "The main User of this PC. Generally my Work PC's are single user, but feel free to add other users if you want.";
    type = types.submodule {
      options = {
        user-name = mkOption {
          description = "linux user-name";
          type = types.str;
        };

        display-name = mkOption {
          description = "User's Full Name to display, for things like login";
          type = types.str;
        };
      };
    };
    default = {
      user-name = "ebarbour";
      display-name = "Emily Barbour";
    };
  }
