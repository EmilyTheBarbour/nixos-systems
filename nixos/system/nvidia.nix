{ config, ... }: {
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    # Disable power management related to the GPU
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Do not use the Open Source Drivers
    open = false;

    # allow configuration using the Linux NvidiaSettings UI/UX
    nvidiaSettings = true;

    # Select the latest production drivers
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
}
