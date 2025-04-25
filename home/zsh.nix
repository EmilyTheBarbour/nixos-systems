{pkgs, ...}: {
  home.packages = with pkgs; [
    nerd-fonts.meslo-lg
    zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${../config/p10k.zsh}

      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

    '';

    autosuggestion.enable = true;
    enableCompletion = true;

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };

  home.shellAliases = {
    nix-local = "nix --builders ''";
    nix-remote = "nix -j0";
    nix-remote-auth = "tsh ls type=nixos-remote-builder";
  };
}
