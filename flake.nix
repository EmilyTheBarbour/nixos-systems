{
  description = "Emily's Personal PC Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    nixgl.url = "github:nix-community/nixGL";

    flake-parts.url = "github:hercules-ci/flake-parts";  
  };

  outputs = { nixpkgs, home-manager, nur, nix-vscode-extensions, nixgl, flake-parts, ... }@inputs:
  let 
	overlays = { 
		default = import ./overlay.nix;
		nur = nur.overlay;
		nix-vscode-extensions = nix-vscode-extensions.overlays.default;
		nixgl = nixgl.overlay;
	};
  in
  flake-parts.lib.mkFlake { inherit inputs; } {
	imports = [
		inputs.home-manager.flakeModules.home-manager
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

		# Actual machines / deployments I use
		homeConfigurations = {};
		nixosConfigurations = {};
	};

	systems = [
		"x86_64-linux"
	];
	perSystem = { config, pkgs, ... }: {
		formatter = pkgs.alejandra;
	};
  };
}
