{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerdfonts
    meslo-lgs-nf
    zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${../config/p10k.zsh}
    '';
  };
}
