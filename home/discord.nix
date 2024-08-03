{ pkgs, lib, config, ...}:
{
  options.sys-config.discord.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "whether to include discord in a system";
  };
  
  config = lib.mkIf config.sys-config.discord.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}