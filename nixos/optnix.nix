{
  options,
  pkgs,
  inputs,
  parameters,
  lib,
  ...
}: let
  inherit (lib) types mkOption;
in {
  imports = [
    inputs.optnix.nixosModules.optnix
  ];

  config = {
    programs.optnix = let
      optnixLib = inputs.optnix.mkLib pkgs;
    in {
      enable = true;
      settings = {
        min_score = 3;
        default_scope = "nixos";
        scopes = {
          nixos = {
            description = "nixos sourced from ${parameters.machine.name}";
            options-list-file = optnixLib.mkOptionsList {inherit options;};
            evaluator = "nix eval ${parameters.machine.flake-location}#nixosConfigurations.${parameters.machine.name}.config.{{ .Option }}";
          };
          home-manager = {
            description = "home-manager sourced from ${parameters.machine.name}";
            options-list-file = optnixLib.hm.mkOptionsListFromHMSource {
              home-manager = inputs.home-manager;
              modules = [
              ];
            };
            evaluator = "nix eval ${parameters.machine.flake-location}#nixosConfigurations.${parameters.machine.name}.config.home-manager.users.${parameters.users.main-user.user-name}.{{ .Option }}";
          };
        };
      };
    };
  };
}
