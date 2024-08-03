{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # memes
    cowsay
    fortune
    lolcat
  ];

  programs.autojump.enable = true;
  programs.bat.enable = true;
  programs.bottom.enable = true;
  programs.broot.enable = true;
  programs.direnv.enable = true;
  programs.eza.enable = true;
  programs.fastfetch.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.git-cliff.enable = true;

  programs.go.enable = true;
  programs.hyfetch.enable = true;
  programs.jq.enable = true;
  programs.navi.enable = true;
  programs.neovim.enable = true;
  programs.obs-studio.enable = true;
  programs.thefuck.enable = true;
  programs.yt-dlp.enable = true;
}
