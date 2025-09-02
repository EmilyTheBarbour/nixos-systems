{ pkgs, lib, ... }: {
  imports = [ ./gnome ];

  options = {
    de.type = lib.mkOption {
      description = "config to inherit for personal DE configs. use \"custom\" to exempt and control this yourself";
      type = pkgs.lib.types.deType;
    };
  };
}
