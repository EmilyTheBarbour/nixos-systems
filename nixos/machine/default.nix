{ pkgs, lib, config, ... }: {
  imports = [
    ./dell-precision-5690
  ];

  options = {
    machine = {
      type = lib.mkOption {
        description = "target machine platform";
        type = lib.types.machineType;
      };

      state-version = lib.mkOption {
        description = "abstraction layer to unify state version for NixOS systems running home-manager";
        type = lib.types.str;
      };
    };
  };

  config = {
    system.stateVersion = config.machine.state-version;

    home-manager.users.${config.main-user.user-name} = {
      config = {
        home.stateVersion = config.machine.state-version;
      };
    };
  };
}
