{ config, pkgs, lib, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config = {
    nixpkgs.hostPlatform = lib.mkForce "x86_64-linux";

    boot =
      {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        initrd = {
          availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
          kernelModules = [ ];
        };

        # Kernel
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

    # CPU
    hardware.cpu.amd.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;

    # GPU
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
  };
}
