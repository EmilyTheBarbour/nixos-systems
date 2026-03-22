{inputs, ...}: {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  # This is from https://github.com/sodiboo/niri-flake
  programs.niri.enable = true;
}
