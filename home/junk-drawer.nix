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
  programs.autojump.enable = true;

  # pretty version of cat
  programs.bat.enable = true;

  # cute looking top replacement (btm)
  programs.bottom.enable = true;

  # open an interactive tree
  programs.broot.enable = true;

  # modern LS replacement (alises ls commands)
  programs.eza.enable = true;

  # neofetch replacement :)
  programs.fastfetch.enable = true;
  programs.hyfetch.enable = true;

  # modern find replacement
  programs.fd.enable = true;

  # fuzzy find (integrates with shell history)
  programs.fzf.enable = true;

  # changelog generator using git commits
  programs.git-cliff.enable = true;

  # json query from the command line :)
  programs.jq.enable = true;

  # community sourced cheatsheet of how to do things with commands
  programs.navi.enable = true;


  # tries to correct your last command
  # programs.pay-resepects.enable = true;

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
  
  # TODO(emily): broken on unstable and not willing to fix it rn
  # programs.sagemath.enable = true;   
}
