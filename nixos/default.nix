{ config
, inputs
, pkgs
, lib
, ...
}: {
  # We realize home-manger via the nixOS module for a unified config here,
  # though this ideally short be exportable for a non NixOS work machine to use
  imports = [
    inputs.home-manager.nixosModules.home-manager

    # Well known machines I've integrated into
    ./machine

    # # Well known desktop environments i've used
    ./de
  ];

  options =
    let
      inherit (lib) types mkOption;
      userOption = types.submodule {
        options = {
          user-name = mkOption {
            description = "linux user-name";
            type = types.str;
          };

          display-name = mkOption {
            description = "User's Full Name to display, for things like login";
            type = types.str;
          };
        };
      };

      mkUserOption = user-name: display-name:
        mkOption {
          description = "The main User of this PC. Generally my Work PC's are single user, but feel free to add other users if you want.";
          type = userOption;
          default = {
            inherit user-name display-name;
          };
        };


    in
    {
      main-user = mkUserOption "emilythebarbour" "Emily Barbour";
    };

  config = {

    # There is always at least 1 user in our systems for now. In the future this
    # may be restrictive (i.e server deployments), but we'll cross that bridge
    # when we get there
    #
    # The general intent here is to generically tie our home-manager user definition
    # and nixOS user definition via a shared type (userOption) that is forwarded
    # through pre-defined home-manager config below
    users.users.${config.main-user.user-name} = {
      isNormalUser = true;
      description = config.main-user.display-name;
      extraGroups = [ "wheel" ];
    };

    home-manager = {
      # Entry-point for the home-manager config modules. Here we enforce that we're only
      # applying config for our main user
      #
      # In the future, this should probably be abstracted for multi-user machines, but
      # i'm not really in the business of having those types of PCs
      users.${config.main-user.user-name} = {
        # the root of my home-manager config; this file tree can be used in isolation for a
        # mostly pure home-manager installation
        imports = [ ../home ];

        # this is the entry-point for NixOS <-> home-manager config passing
        config = {
          main-user = config.main-user;
        };
      };

      # inherit's all my nixpkgs config from the NixOS side of the house
      useGlobalPkgs = true;

      # DO add the specified packages from my home-manager config to my system
      useUserPackages = true;

      # Also follow the SpecialArgs inputs approach used in my normal NixOS config
      extraSpecialArgs = {
        inherit inputs;
      };

      backupFileExtension = "backup";
    };
  };
}
