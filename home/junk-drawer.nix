# collection of different packages and programs
#
{pkgs, ...}: {
  home.packages = with pkgs; [
    # memes
    cowsay
    fortune
    lolcat
    pokemonsay
    gparted
    tldr

    nix-search-cli
  ];

  home.shellAliases = {
    lucky-cow = "fortune | cowsay | lolcat";
    smart-pokemon = "fortune | pokemonsay";
  };

  # easy way to "jump" around to different directories
  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  # pretty version of cat
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
  };

  # cute looking top replacement (btm)
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        current_usage = true;
        tree = true;
        battery = true;
      };
    };
  };

  # open an interactive tree
  programs.broot = {
    enable = true;
    enableZshIntegration = true;
  };

  # modern LS replacement (alises ls commands)
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "always";
    colors = "always";
  };

  # neofetch replacement :)
  programs.fastfetch.enable = true;
  programs.hyfetch.enable = true;

  # modern find replacement
  programs.fd.enable = true;
  home.shellAliases = {
    find = "fd";
  };

  # fuzzy find (integrates with shell history)
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.mcfly = {
    enable = true;
    enableZshIntegration = true;
    fzf.enable = true;
    keyScheme = "vim";
  };

  # changelog generator using git commits
  programs.git-cliff.enable = true;

  # json query from the command line :)
  programs.jq.enable = true;
  programs.jqp.enable = true;

  # community sourced cheatsheet of how to do things with commands
  programs.navi = {
    enable = true;
    enableZshIntegration = true;
  };

  # CLI to download yt videos
  programs.yt-dlp.enable = true;

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  services.tldr-update.enable = true;

  programs.sagemath.enable = true;

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
    };
  };
}
