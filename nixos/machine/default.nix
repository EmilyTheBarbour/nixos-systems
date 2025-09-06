{
  lib,
  parameters,
  ...
}: let
  # Custom bypasses the machinery and lets you define your own
  machineMapping = {
    dell-precision-5690 = lib.trace "selected dell-precision-5690 machine archetype" ./dell-precision-5690;
    generic-desktop-x86 = lib.trace "selected generic-desktop-x86 machine archetype" ./generic-desktop-x86;
  };
in {
  imports =
    if builtins.hasAttr parameters.machine.type machineMapping
    then [(lib.getAttr parameters.machine.type machineMapping)]
    else [];

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
