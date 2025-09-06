{ lib, parameters, ... }:
let
  # Custom bypasses the machinery and lets you define your own
  machineMapping = {
    dell-precision-5690 = ./dell-precision-5690;
    generic-desktop-x86 = ./generic-desktop-x86;
  };

in
{
  imports = (if machineMapping ? parameter.machine.type then [ (lib.getAttr parameters.machine.type machineMapping) ] else [ ]);

  config = {
    # set our system architecture here
    nixpkgs.hostPlatform = parameters.machine.system;
    
    # also set our original state-version across both nix and home-manager
    system.stateVersion = parameters.machine.state-version;
    home-manager.users.${parameters.users.main-user.user-name} = {
      config = {
        home.stateVersion = parameters.machine.state-version;
      };
    };
  };
}
