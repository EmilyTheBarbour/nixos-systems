{

  programs.terminator = {
    enable = true;
    config = {
      profiles.default = {
        font = "MesloLGS Nerd Font Regular 12";
        use_system_font = false;
        scrollback_infinite = true;

        # Catppuccin Frappe
        cursor_color = "#f2d5cf";
        background_color = "#303446";
        foreground_color = "#c6d0f5";
        palette = "#51576d:#e78284:#a6d189:#e5c890:#8caaee:#f4b8e4:#81c8be:#b5bfe2:#626880:#e78284:#a6d189:#e5c890:#8caaee:#f4b8e4:#81c8be:#a5adce";
        background_image = "None";
      };
    };
  };
}
