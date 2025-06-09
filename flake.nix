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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    nix-vscode-extensions,
    flake-parts,
    ...
  } @ inputs: let
    overlays = {
      default = import ./overlay.nix;
      nur = nur.overlays.default;
      nix-vscode-extensions = nix-vscode-extensions.overlays.default;
    };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
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
        homeModules = import ./home/module-list.nix;
        nixosModules = import ./nixos/module-list.nix;

        # Actual machines / deployments I use for personal machines
        homeConfigurations = {};
        nixosConfigurations = {};
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
        # This correctly consumes our overlays as defined above
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = (builtins.attrValues self.overlays);
        };
        legacyPackages = pkgs; # re-export them for easy REPL

        formatter = pkgs.alejandra;
      };
    };
}
