{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  # import only home-manager modules that work
  # for all linux systems
  imports = [
    self.homeModules.common-linux
  ];

  home.username = flake.config.people.myself;
  home.homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${flake.config.people.myself}";
  
  # allow home-manager to manage fonts
  fonts.fontconfig.enable = true;
  
  programs.home-manager.enable = true;
}
