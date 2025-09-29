{
  inputs,
  lib,
  ...
}: {
  imports = [
    # 5490 is just the 14" version of the 5690. Otherwise, hardware seems
    # to be identical
    inputs.nixos-hardware.nixosModules.dell-precision-5490

    # Static hardware config for a 5690 With GPU support in X11.
    # This should be generally trivially copyable to other closures without
    # much modification
    ./hardware.nix

    ./camera.nix
  ];

  options = {
    machine.dell-precision-5690.enable-camera-config = lib.mkEnableOption "enable experimental camera support";
    machine.dell-precision-5690.disable-intel = lib.mkEnableOption "disable intel gpu, only allowing external displays";
  };
}
