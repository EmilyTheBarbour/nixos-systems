{ self, ... }:
{
  flake = {
    homeModules = {
      # All systems will shared these modules no matter what
      common = {
        home.stateVersion = "24.05";
        imports = [
        ];
      };

      # NixOS + Home-Manager enabled Linux distros only
      common-linux = {
        imports = [
          self.homeModules.common
          ./vscode.nix
          ({ config, pkgs, ... }: {
            home.packages = with pkgs; [
              # memes
              cowsay
              fortune
              lolcat

              # zsh configuration
              nerdfonts
              meslo-lgs-nf
              zsh-powerlevel10k

              # automagic path injection for graphics drivers
              # nixgl.auto.nixGLDefault
              # nixgl.auto.nixVulkanNvidia

              # glxinfo
            ];

            programs.firefox.enable = true;
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

            programs.git.enable = true;
            programs.git.userEmail = "emilythebarbour@gmail.com";
            programs.git.userName = "Emily Barbour";

            programs.terminator.enable = true;
            programs.terminator.config = {
              profiles.default.font = "MesloLGS Nerd Font Regular 12";
              profiles.default.use_system_font = false;
            };

            programs.zsh.enable = true;
            programs.zsh.initExtra = ''
              source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
              source ${../config/.p10k.zsh}
            '';
            programs.zsh.shellAliases = {
              switch = "sudo nixos-rebuild switch --flake /home/emily/config --impure";
            };
          })
        ];
      };

      # Darwin Only
      common-darwin = {
        imports = [
          self.homeModules.common
        ];
      };
    };
  };
}
