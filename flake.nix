{
  description = "Emily's Personal PC Configurations";

  inputs = {
    # Unstable is honestly pretty stable, plus you get nearly the latest and
    # greatest of linux
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # the flake-parts home-manager module is broken on master, so i've fixed on
    # my own fork that I merge with upstream every update.
    # TODO(emily): submit a PR to get us back onto their origin
    home-manager.url = "github:EmilyTheBarbour/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Additional community provided derivations that operate at a more "move fast and break things"
    # pace.
    nur.url = "github:nix-community/NUR";

    # Nix + nightly CI Infra which automatically create derivations of every VSCode extension on the
    # MS Marketplace automatically. Occasionally breaks though, just give it until the next nightly
    # to fix
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # I prefer the flake-parts flake definition schema
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nur
    , nix-vscode-extensions
    , flake-parts
    , nixos-hardware
    , ...
    } @ inputs:
    let
      overlays = {
        default = import ./overlay.nix;
        nur = nur.overlays.default;
        nix-vscode-extensions = nix-vscode-extensions.overlays.default;
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      # Simple ability to export home-manager modules separately from
      # our nixosModules so consumers down the line that are nonNixOS
      # machines can still reap the benefits of our home-manager config
      imports = [
        home-manager.flakeModules.home-manager
      ];

      flake = {
        # re-export the overlays used throughout our configurations
        # so consumers of our modules can quickly import them
        inherit overlays;

        # un-realized modules for HomeManager and NixOS respectively, which
        # can later be composed into systems through Configurations.
        # an attrset
        homeModules = {
          default = import ./home;
        };

        nixosModules = {
          default = import ./nixos;
        };

        # Actual machines / deployments I use for personal machines
        homeConfigurations = { };
        nixosConfigurations = {
          # Example usage of this repository to generate a system closure
          example = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            # This is a bit of a smell, but for now we're only enforcing
            # the user provide inputs.home-manager.
            #
            # In the future, there may need to be additional machinery
            # surrounding this
            specialArgs = {
              inputs = inputs;
            };

            modules = [
              # directly pull our resultant core module, users would pull this
              # off output
              self.nixosModules.default

              # Minimum viable config, in addition to the config.nix generated on install
              # to use this repository
              ({ config, lib, ... }: {
                main-user = lib.mkForce {
                  user-name = "ebarbour";
                  display-name = "Emily Barbour";
                };

                machine = {
                  type = lib.mkForce "dell-precision-5690";
                  state-version = "24.11";
                };

                de.type = "gnome";
              })

              # Apply our overlays. At a minimum, they need to be the self.overlays,
              # but practically users should compose our overlays with theirs prior
              # to application
              { nixpkgs.overlays = builtins.attrValues overlays; }
            ];
          };
        };
      };

      # shorthand to add a formatter for each machine arch I use
      systems = [
        "x86_64-linux"
      ];
      perSystem =
        { config
        , pkgs
        , system
        , lib
        , ...
        }: {
          # This correctly consumes our overlays as defined above for
          # local usage of this flake
          #
          # Consumers of this flake should apply the same mechanism in
          # addition to their overlays
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = builtins.attrValues self.overlays;
          };

          legacyPackages = pkgs; # re-export them for easy REPL

          formatter = pkgs.alejandra;
        };
    };
}
