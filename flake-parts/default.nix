# Forward a local copy of Self to all of our modules which always points to nixos-systems,
# irregardless of the import location (i.e my work closure)
local_flake: {...}: {
  imports = [
    # This is the machinery required to generate N different deployments
    (import ./deployment local_flake)
  ];
}
