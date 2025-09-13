# nixos-systems
Core NIX configuration shared across all of my nix enabled environments. This currently includes:

* Personal Gaming / Development PC
* Work Laptop 

# Flake Structure
While some folks prefer to utilize a generator pattern, wherein a custom "build machine" function is provided, This instead leverages [flake-parts](https://flake.parts/) modules

## Flake Parts
The following are the current flake-parts modules users will gain when they import `nixos-systems.flakeModules.default`, which is a requirement for external consumption as identified [External Consumption](#external-consumption)

### `deployment`

defines the `deployments` flake-parts option, which is a simple list of deployment configs.

#### Parameters

* de -> collection of options associated with common configurations i've curated for desktop environments
* machine.type -> collection of options associated with common machine / hardware configs I've deployed on thus far
* machine.name -> resultant output.nixosConfiguration attrName generated
* users.main-user -> user-name and display-name for all config associated with a user
* modules -> additional nixOS modules you wish to define. You can also inject home-manager modules via the normal nixOS config options here
* gaming.enable -> escape hatch for disabling gaming related programs and services which shouldn't be on certain types of machines (such as work PCs, embedded, etc.)

#### Usage in nixOS

For each deployment, a nixOS closure is created and added as an output. a specialArgument is also added (which means all of the modules in this repository have a hard dependency on this pattern), `parameters`, which contains the options in the submodule above.

## nixOS

This is the collection of nixOS modules defined in this repository, with an explicit dependency on the [deployment](#deployment) flake-parts module pattern. These are exported for convenience as `outputs.nixosModules`. 


## home-manager (home)

This is the collection of home-manager modules defined in this repository, with an explicit dependency on the [deployment](#deployment) flake-parts module pattern. These are exported for convenience as `outputs.nixosModules`. 

# Configuration Groups

The following goes more into depth the specified parameter groups in [deployment](#deployment)

## de (desktop environment)
Collection of hand-crafted desktop environment setups I've used across my machines.

## machine
Collection of different hardware types I've integrated with thus far

## gaming
Collection of gaming related services and programs, which can be easily removed from any closure

# Defining a new Deployment

The following is a minimal example to define a deployment *in this repository*:

flake-parts config
```nix
{
    deployments = [{
        machine.name = "<resultant nixosConfiguration attrName>";
        # List of additional nixOS Modules to import. Generally things that are super specific
        # to a singular hardware device, such as file system IDs, etc. 
        modules = [
            # here is an example of pulling in the specialArg of the submodule you're currently
            # defining. For example, parameters.machine.name will be what you defined above.
            ({parameters, ...}: {
               # ... 
            })
        ];
    }];
}
```

# External Consumption
If you wish to use this repository externally, here is the rough flake structure recommended for
consumption:

```nix
{
    inputs = {
        # pull it in
        nixos-systems.url = "github:EmilyTheBarbour/nixos-systems/";

        # here are the minimum set of flake inputs you must have. either pull 
        # them from nixos-systems or override them with what you want
        nixpkgs.follows = "nixos-systems/nixpkgs";
        nixos-hardware.follows = "nixos-systems/nixos-hardware";
        flake-parts.follows = "nixos-systems/flake-parts";
    };
    outputs = {
        self,
        nixpkgs,
        nixos-systems,
        nixos-hardware,
        flake-parts,
        ...
    } @ inputs: flake-parts.lib.mkFlake { inherit inputs; } ({...}: {
        imports = [
            nixos-systems.flakeModules.default

            # define your deployments here!
            {
                deployments = [
                    # example deployment
                    { machine.name = "foo"; }
                ];
            }
        ];
        
        systems = [
            "x86_64-linux"
        ];
        perSystem = {
            pkgs,
            system
            ...
        }: {
            # Optional if you want it to be easier to debug overlays,
            # i.e with repl
            _module.args.pkgs = import inputs.nixpkgs {
                inherit system;
                overlays = builtins.attrValues nixos-systems.overlays;
            };

            # again, for easy REPL
            legacyPackages = pkgs;

            # Pick your poison here
            formatter = pkgs.alejandra;
        };
    });
}
```

# TODO
- [ ] Simplify overlay consumption for external consumers
- [ ] More formally label each module group for support for more niche deployments, such as WSL or nix-darwin
- [ ] multi-user deployments

