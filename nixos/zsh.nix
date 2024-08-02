{ flake, pkgs, ... }:

{
  # set the default shell, we include it in our home-manager
  # config which NixOS doesn't have introspection into, so 
  # disable the shell check
  users.users.${flake.config.people.myself} = {
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
}
