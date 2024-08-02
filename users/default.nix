{ lib, ... }:

with lib;
with types;

let
  # Define a user, which provides the ability to contextualize other nix flake modules
  userSubmodule = submodule {
    options = {
      name = mkOption {
        type = str;
      };
      email = mkOption {
        type = str;
      };
    };
  };

  # this repository has a list of users, and one marked as the main user (i.e me)
  peopleSubmodule = submodule {
    options = {
      # the key for this attrset is their username
      users = mkOption {
        type = attrsOf userSubmodule;
      };
      myself = mkOption {
        type = str;
        description = ''
          The name of the user which represents myself. 
        '';
      };
    };
  };
in

{
  options = {
    people = mkOption {
      type = peopleSubmodule;
    };
  };

  config = {
    people = import ./config.nix;
  };
}
