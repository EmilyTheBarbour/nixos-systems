{
  parameters,
  lib,
  ...
}: {
  imports =
    if parameters.gaming.enable == true
    then
      lib.trace "enabling gaming modules in home-manager" [
        ./lutris.nix
        ./osu.nix
        ./discord.nix
        ./wallpaper-engine.nix
        ./runelite.nix
        ./prismlauncher.nix
      ]
    else [];
}
