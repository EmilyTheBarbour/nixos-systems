local_flake: {
  lib,
  inputs,
  config,
  ...
}: let
  inherit (lib) types mkOption;
  parameters = import ./parameters.nix lib;
in {
  options = {
    deployments = mkOption {
      type = types.listOf parameters;
      default = [];
      description = "system configs";
    };
  };

  config.flake = {
    # Generate a nixosConfiguration for each deployment
    nixosConfigurations = (
      builtins.listToAttrs
      # map each to attrSet of a singular nixosConfig
      (lib.map
        (parameters: {
          name = parameters.machine.name;
          value = inputs.nixpkgs.lib.nixosSystem {
            # system architecture
            inherit (parameters.machine) system;

            # forward along our parameterization so it can be used
            # note, these values are already realized, prior to eval of
            # this closure, thus it circumvents potential infinite recursion
            # issues
            specialArgs = {
              inherit parameters inputs;
            };

            modules =
              [
                # Always include our entry-point for system config
                # Parameterization of individual system config is done off of
                # flake-parts eval time -> specialArgs, breaking infinite recursion
                # issues, thus allowing us perform conditional imports
                local_flake.nixosModules.default

                # Theming Engine for NixOS
                inputs.stylix.nixosModules.stylix

                # easy point to include overlays for now, probably want to paramterize
                # this further down the line
                {
                  nixpkgs.overlays = builtins.attrValues local_flake.overlays;

                  home-manager = {
                    # Entry-point for the home-manager config modules. Here we enforce that we're only
                    # applying config for our main user
                    #
                    # In the future, this should probably be abstracted for multi-user machines, but
                    # i'm not really in the business of having those types of PCs
                    users.${parameters.users.main-user.user-name} = {
                      # the root of my home-manager config; this file tree can be used in isolation for a
                      # mostly pure home-manager installation
                      imports = builtins.attrValues local_flake.homeModules;
                    };
                  };
                }
              ]
              # Additonally include the user provided modules for their custom overrides
              ++ parameters.modules;
          };
        })
        config.deployments)
    );
  };
}
