{parameters, ...}: {
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
    ./gimp.nix
    ./flameshot.nix
    ./neovim.nix

    ./gaming
    ./de
  ];

  config = {
    # Required Home manager config to integrate with this machine
    home.username = parameters.users.main-user.user-name;
    home.homeDirectory = "/home/${parameters.users.main-user.user-name}";
    programs.home-manager.enable = true;
  };
}
