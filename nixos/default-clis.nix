{pkgs, ...}: {
  # These are a subset of options which are required at the NixOS level to set default
  # preferences for tools, such as text editors. Config here is as small as possible
  # purposefully relying on it to be defined in my home-manager config for more of it
  # to be transferable to other platforms

  # set Neovim to the default editor
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # As well as ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
