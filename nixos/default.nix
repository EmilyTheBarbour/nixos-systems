{
  inputs,
  parameters,
  ...
}: {
  # We realize home-manger via the nixOS module for a unified config here,
  # though this ideally short be exportable for a non NixOS work machine to use
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-cli.nixosModules.nixos-cli

    # Well known machines I've integrated into
    ./machine

    # # Well known desktop environments i've used
    ./de

    # scope of gaming related options. Generally will be disabled
    # on productivity machines (i.e work)
    ./gaming

    # Nix configuration defaults I like
    ./nix.nix

    # Additional, generic config
    ./default-clis.nix
    ./locale.nix
    ./networking.nix
    ./wireshark.nix
    ./input.nix
    ./audio.nix
    ./kernel.nix
    ./bottles.nix
    ./optnix.nix
    ./stylix.nix
    ./qmk.nix
    ./gdb.nix
    ./photography.nix
  ];

  config = {
    programs.nixos-cli = {
      enable = true;
      settings = {
        config_location = "${parameters.machine.flake-location}";
      };
    };

    # There is always at least 1 user in our systems for now. In the future this
    # may be restrictive (i.e server deployments), but we'll cross that bridge
    # when we get there
    #
    # The general intent here is to generically tie our home-manager user definition
    # and nixOS user definition via a shared type (userOption) that is forwarded
    # through pre-defined home-manager config below
    users.users.${parameters.users.main-user.user-name} = {
      isNormalUser = true;
      description = parameters.users.main-user.display-name;
      extraGroups = ["wheel"];
    };

    home-manager = {
      # Entry-point for the home-manager config modules. Here we enforce that we're only
      # applying config for our main user
      #
      # In the future, this should probably be abstracted for multi-user machines, but
      # i'm not really in the business of having those types of PCs
      users.${parameters.users.main-user.user-name} = {
        # the root of my home-manager config; this file tree can be used in isolation for a
        # mostly pure home-manager installation
        imports = [
          ../home
        ];
      };

      # inherit's all my nixpkgs config from the NixOS side of the house
      useGlobalPkgs = true;

      # DO add the specified packages from my home-manager config to my system
      useUserPackages = true;

      # Also follow the SpecialArgs inputs approach used in my normal NixOS config
      extraSpecialArgs = {
        inherit inputs parameters;
      };

      backupFileExtension = "backup";
    };
  };
}
