{pkgs, ...}: {
  # obviously
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      vim-surround
      substitute-nvim
    ];

    # Enable substitute keybinds
    extraLuaConfig = ''
      vim.keymap.set("n", "s", require('substitute').operator, { noremap = true })
      vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
      vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
      vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })
    '';

    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
  };
}
