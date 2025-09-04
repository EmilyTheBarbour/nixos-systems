{ lib, config, ... }: {
  imports = [
    ./dell-precision-5690
  ];

  options =
    let
      machineType =
        lib.types.enum [
          "dell-precision-5690"

          # user consents to having a special machine that hasn't been integrated
          # with yet, and that they will maintain that specifically for themselves
          "custom"
        ];
    in
    {
      machine = {
        type = lib.mkOption {
          description = "target machine platform";
          type = machineType;
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
