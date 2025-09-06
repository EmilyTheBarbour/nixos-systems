{config, ...}: {
  nixpkgs.hostPlatform = "x86_64-linux";

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  # CPU
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  # GPU
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

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

  # Input
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };
  services.xserver.libinput.enable = true;
  services.xserver.libinput.mouse.accelProfile = "flat";

  # Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
