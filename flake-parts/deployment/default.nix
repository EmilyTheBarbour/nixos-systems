{
  lib,
  inputs,
  config,
  self,
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
                self.nixosModules.default

                # easy point to include overlays for now, probably want to paramterize
                # this further down the line
                {nixpkgs.overlays = builtins.attrValues self.overlays;}
              ]
              # Additonally include the user provided modules for their custom overrides
              ++ parameters.modules;
          };
        })
        config.deployments)
    );
  };
}
