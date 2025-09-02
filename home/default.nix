{
  pkgs,
  config,
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

  options = {
    # Same as the NixOS config side of the house, a unified definition for the target
    # user of this machine, when configuring user related properties or permissions
    main-user = pkgs.lib.types.mkUserOption "emilythebarbour" "Emily Barbour";
  };

  config = {
    # Required Home manager config to integrate with this machine
    home.username = config.main-user.user-name;
    home.homeDirectory = "/home/${config.main-user.user-name}";
    programs.home-manager.enable = true;
  };
}
