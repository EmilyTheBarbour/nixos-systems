{
  description = "Emily's Personal PC Configurations";

  inputs = {
    # Unstable is honestly pretty stable, plus you get nearly the latest and
    # greatest of linux
    nixpkgs.url = "github:nixOS/nixpkgs/";
    nixpkgs-unstable.url = "github:nixOS/nixpkgs/nixos-unstable";

    # the flake-parts home-manager module is broken on master, so i've fixed on
    # my own fork that I merge with upstream every update.
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Additional community provided derivations that operate at a more "move fast and break things"
    # pace.
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    # Nix + nightly CI Infra which automatically create derivations of every VSCode extension on the
    # MS Marketplace automatically. Occasionally breaks though, just give it until the next nightly
    # to fix
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    # base hardware configs to easily inherit from
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # I prefer the flake-parts flake definition schema
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Additional Flakes I've started using
    treefmt-nix.url = "github:numtide/treefmt-nix"; # global formatting
    catppuccin.url = "github:catppuccin/nix"; # Theming
    optnix.url = "github:water-sucks/optnix"; # Nix Options Searching TUI
    nixos-cli.url = "github:nix-community/nixos-cli";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    nix-vscode-extensions,
    flake-parts,
    treefmt-nix,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({flake-parts-lib, ...}: let
      overlays = {
        default = import ./overlay.nix inputs;
        nur = nur.overlays.default;
        nix-vscode-extensions = nix-vscode-extensions.overlays.default;
      };

      # un-realized modules for HomeManager and NixOS respectively, which
      # can later be composed into systems through Configurations.
      # Note: these have an implicit dependency on `self.flakeModules.default`
      homeModules = {
        default = import ./home;
      };

      nixosModules = {
        default = import ./nixos;
      };

      flakeModules = let
        inherit (flake-parts-lib) importApply;
      in {
        # This pairs our flakeModule with our overlays, homeModules, and nixosModules defined in this flake
        # note: this particularly enforces that everyone needs to consume our overlays as defined in this flake
        # including Nur + nix-vscode-extensions, so in theory that means they don't have to apply them either?
        # To be determined
        default = importApply ./flake-parts {inherit overlays homeModules nixosModules;};
      };
    in {
      debug = true;

      # Simple ability to export home-manager modules separately from
      # our nixosModules so consumers down the line that are nonNixOS
      # machines can still reap the benefits of our home-manager config
      imports =
        (builtins.attrValues flakeModules)
        ++ [
          home-manager.flakeModules.home-manager
          flake-parts.flakeModules.flakeModules

          # Define my own deployments for now here
          {
            deployments = [
              # Gaming / Personal Development Desktop (AMD CPU + Nvidia GPU)
              (import ./deployments/personal-pc.nix)
            ];
          }
        ];

      flake = {
        # re-export the overlays used throughout our configurations
        # so consumers of our modules can quickly import them
        inherit overlays flakeModules nixosModules homeModules;
      };

      # shorthand to add a formatter for each machine arch I use
      systems = [
        "x86_64-linux"
      ];
      perSystem = {
        config,
        pkgs,
        system,
        lib,
        ...
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
      };
    });
}
