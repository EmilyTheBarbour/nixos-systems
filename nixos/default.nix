{ self, config, ... }:
{
  flake = {
    nixosModules = {
      # These are shared between Nix-OS and Darwin
      common.imports = [
        ./nix.nix
      ];

      # NixOS will always have a home-manager config,
      my-home = {
        # create a user for myself
        users.users.${config.people.myself} = {
          isNormalUser = true;
        };

        # populate home-manager for this user
        home-manager.users.${config.people.myself} = {
          imports = [
            self.homeModules.common-linux
            # ../home/de/sway.nix
          ];
        };

        home-manager.backupFileExtension = "backup";
      };

      # The specialized set of imports specifically for a NixOS System
      default.imports = [
        # core set of module endpoints
        self.nixosModules.home-manager
        self.nixosModules.my-home
        self.nixosModules.common

        # audio
        ./pipewire.nix

        # common interfaces
        ./keyboard.nix
        ./locale.nix
        ./printer.nix

        # set zsh as default shell
        ./zsh.nix
      ];
    };
  };
}
