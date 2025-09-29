{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      obsidian
    ];

    programs.obsidian = {
      enable = true;

      defaultSettings = {
        app = {
          "vimMode" = true;
        };

        # appearance = {
        #   "cssTheme" = "Catppuccin";
        # };
      };
    };
  };
}
