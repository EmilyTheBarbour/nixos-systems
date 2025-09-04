{
  pkgs,
  config,
  lib,
  ...
}: {
  # All of our common modules across the home-manager config space
  imports = [
    ./direnv.nix
    ./firefox.nix
    ./fonts.nix
    ./git.nix
    ./obsidian.nix
    ./terminator.nix
    ./video-editing.nix
    ./vscode.nix
    ./zsh.nix
    ./junk-drawer.nix
    ./chromium.nix
    ./office.nix
    ./de
  ];

  options =
    let
      inherit (lib) types mkOption;
      userOption = types.submodule {
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

      mkUserOption = user-name: display-name:
        mkOption {
          description = "The main User of this PC. Generally my Work PC's are single user, but feel free to add other users if you want.";
          type = userOption;
          default = {
            inherit user-name display-name;
          };
        };


    in
    {
      main-user = mkUserOption "emilythebarbour" "Emily Barbour";
    };

  config = {
    # Required Home manager config to integrate with this machine
    home.username = config.main-user.user-name;
    home.homeDirectory = "/home/${config.main-user.user-name}";
    programs.home-manager.enable = true;
  };
}
