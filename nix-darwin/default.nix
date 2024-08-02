{ self, config, ... }:
{
  flake = {
    darwinModules = {
      # register user configuration for this system
      my-home = {
        # we don't create users in darwin, but we can
        # still instantiate home-manager for an existing user
        # that maps to myself
        home-manager.users.${config.people.myself} = {
          imports = [
            self.homeModules.common-darwin
          ];
        };
      };

      # Specialized set of inputs specifically for Darwin
      default.imports = [
        # core set of darwin modules
        self.darwinModules_.home-manager
        self.darwinModules.my-home
        self.nixosModules.common
      ];
    };
  };
}
