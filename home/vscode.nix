{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with builtins; let
  # grab the extra-wordlists from the config
  extra-wordlists = config.sys-config.vscode.extra-wordlists;

  # For each user supplied wordlist, grab the whitelist from it
  # then, flatten all of the resultant whitelists into a single whitelist
  word-whitelist = lists.flatten (forEach extra-wordlists (x: x.whitelist));
in {
  options.sys-config.vscode = {
    extra-wordlists = mkOption {
      type = types.listOf types.attrs;
      default = [];
      example = ''
        # word-list.json
        {
          "whitelist": [
            "foo",
            "bar
          ]
        }

        # module.nix
        extra-wordlists = [(builtins.fromJSON (builtins.readFile ./word-list.json))]
      '';
    };
  };

  config = {
    # Package Dependencies for our Plugins
    home.packages = with pkgs; [
      # C++ dependencies for plugins
      cmake
      clang-tools

      # Nix Depedencies for plugins
      nixpkgs-fmt
      nil
    ];

    home.shellAliases = let code-path = (lib.getExe config.programs.vscode.package); in {
      "code" = code-path;
      "vscode" = code-path;
    };

    # Program Dependencies for our Plugins
    programs.direnv.enable = mkForce true;
    programs.neovim.enable = mkForce true;

    # Configure VSCode
    programs.vscode = {
      # Use the OSS Version that has AI stuff stripped out
      package = pkgs.vscodium;

      enable = true;

      # prevent vscode from taking ownership of my extensiosn
      mutableExtensionsDir = false;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        extensions = with pkgs.vscode-marketplace; [
          # Theme
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons

          # documentation
          bbenoist.doxygen
          cschlosser.doxdocgen

          # git
          eamodio.gitlens

          # Matlab
          mathworks.language-matlab

          # nix
          jnoortheen.nix-ide

          # rust
          rust-lang.rust-analyzer
          pkgs.vscode-extensions.vadimcn.vscode-lldb

          # python
          ms-python.python
          ms-python.vscode-pylance
          ms-python.debugpy
          njpwerner.autodocstring
          kevinrose.vsc-python-indent

          # jupyter
          ms-toolsai.jupyter
          ms-toolsai.vscode-jupyter-powertoys

          # C++
          llvm-vs-code-extensions.vscode-clangd
          # vadimcn.vscode-lldb
          twxs.cmake

          ms-vscode.live-server
          ms-vscode.hexeditor

          # JS/TS
          ms-vscode.vscode-typescript-next

          # Jinja
          samuelcolvin.jinjahtml

          # YAML
          redhat.vscode-yaml

          # BASH
          shakram02.bash-beautify

          # Protobuf
          zxh404.vscode-proto3

          # helpers
          gruntfuggly.todo-tree
          wayou.vscode-todo-highlight
          amodio.restore-editors
          lacroixdavid1.vscode-format-context-menu
          streetsidesoftware.code-spell-checker
          yutengjing.open-in-external-app
          mkhl.direnv
          asvetliakov.vscode-neovim
        ];

        userSettings = {
          "workbench.colorTheme" = "Catppuccin Frappé";
          "workbench.iconTheme" = "catppuccin-frappe";
          "terminal.integrated.fontFamily" = "MesloLGS Nerd Font";

          "nix.enableLanguageServer" = true;
          "nix.serverSettings" = {
            "nil" = {"formatting" = {command = ["nixpkgs-fmt"];};};
          };

          "extensions.experimental.affinity" = {
            "asvetliakov.vscode-neovim" = 1;
          };

          "doxdocgen.file.fileOrder" = [
            "file"
            "author"
            "date"
            "empty"
            "brief"
          ];
          "doxdocgen.generic.useGitUserName" = true;

          "C_Cpp.doxygen.generatedStyle" = "/**";
          "C_Cpp.clang_format_stype" = "{ BasedOnStyle = Google; IndentWidth = 4; TabWidth = 4 }";
          "C_Cpp.intelliSenseEngine" = "disabled";

          "files.exclude" = {
            "**/.git" = true;
            "**/.svn" = true;
            "**/.hg" = true;
            "**/CVS" = true;
            "**/.DS_Store" = true;
            "**/Thumbs.db" = true;
            "/bin" = true;
            "/boot" = true;
            "/cdrom" = true;
            "/dev" = true;
            "/proc" = true;
            "/etc" = true;
          };

          "terminal.integrated.enableMultiLinePasteWarning" = "never";

          "editor.formatOnSave" = false;
          "editor.formatOnSaveMode" = "modifications";
          "editor.stickyScroll.enabled" = true;

          "extensions.ignoreRecommendations" = true;

          "search.followSymlinks" = false;

          # apply all of the user provided word whitelists
          "cSpell.userWords" = word-whitelist;
        };
      };
    };
  };
}
