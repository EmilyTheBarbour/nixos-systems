{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # memes
    cowsay
    fortune
    lolcat
    pokemonsay 

    python3
  ];
  
  home.shellAliases = {
    lucky-cow = "fortune | cowsay | lolcat";
    smart-pokemon = "fortune | pokemonsay";
  };
  
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Frappe";
    font = {
      name = "MesloLGS Nerd Font";
      size = 12;
    };
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
  
  # obviously
  programs.neovim.enable = true;
  
  # tries to correct your last command 
  programs.thefuck.enable = true;
  
  # CLI to download yt videos 
  programs.yt-dlp.enable = true;
}
