{ self, ... }:
{
  flake = {
    homeModules = {
      # All systems will shared these modules no matter what
      common = {
        home.stateVersion = "24.05";
        imports = [
          ./git.nix
        ];
      };

      # NixOS + Home-Manager enabled Linux distros only
      common-linux = {
        imports = [
          self.homeModules.common
          ./vscode.nix
          ./terminator.nix
          ./zsh.nix
          ({ config, pkgs, ... }: {
            home.packages = with pkgs; [
              # memes
              cowsay
              fortune
              lolcat
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
