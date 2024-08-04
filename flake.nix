{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # additional inputs which we will track at a less frequent cadence
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      # The systems where we have support for deploying environments into
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];

      # flake-parts modules which expose extra options and config we can use throughout
      # the rest of our flake. Similar to how NixOS handles modules (options + config)
      imports = [
        inputs.nixos-flake.flakeModule
        ./users
        ./home
        ./nixos
        ./nix-darwin
      ];

      # the list of configurations
      flake = {
        nixosConfigurations.personal-pc = self.nixos-flake.lib.mkLinuxSystem ./systems/personal-pc.nix;
        nixosConfigurations.wsl-env = self.nixos-flake.lib.mkLinuxSystem ./systems/nixos-wsl.nix;
      };

      # for each system above, build out the workflow of developing, updating, and activating a system.
      perSystem = { self', inputs', pkgs, system, config, ... }: {
        nixos-flake = {
          # defines the subset of our flake-inputs which are deemed "main" inputs
          # which we specifically don't need / want to track specific revisions
          # these are updated through nix run .#update
          # you can think of this as very similar to a sudo apt upgrade
          primary-inputs = [
            "nixpkgs"
            "home-manager"
            "nix-darwin"
            "nixos-flake"
            "nur"
            "nixos-wsl"
            "nix-vscode-extensions"
          ];
        };

        # Define a home-manager system that will work across all target architectures for any linux system
        # TODO(emily): is this the best way to handle overlays? There seems to be a schism
        # between how NixOS based systems handle overlays with the module option, and how
        # other types of systems apply them.
        legacyPackages.homeConfigurations."emily" = inputs.self.nixos-flake.lib.mkHomeConfiguration
          (import inputs.nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
            };

            overlays = with inputs; [
              nur.overlay
              nix-vscode-extensions.overlays.default
              inputs.nixgl.overlay
            ];
          }) ./systems/non-nixos-pc.nix;

        # provides the ability to nix run to activate the resultant nixOS configuration
        # by default, it will choose the configuration who's host name matches, otherwise
        # you can explicitly specify the hostname to use
        packages.default = self'.packages.activate;

        # define the format style to use for this repository
        formatter = pkgs.nixpkgs-fmt;

        # provides easy access to packages for development within the context of this repo
        devShells.default = pkgs.mkShell {
          inputsFrom = [ ];
          packages = with pkgs; [
            nil
            nixpkgs-fmt
          ];

          # provide our packages overlay as an input to our development shell
          # _module.args.pkgs = import inputs.nixpkgs {
          #   inherit system;
          #   overlays = [
          #     (import ./packages/overlay.nix { inherit system; flake = { inherit inputs; }; })
          #   ];
          # };
        };
      };
    };
}
