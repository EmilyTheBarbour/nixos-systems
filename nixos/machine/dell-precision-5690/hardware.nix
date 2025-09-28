{
  config,
  lib,
  modulesPath,
  inputs,
  ...
}:
# Don't tell the NixOS police, but I manually edited this file :)
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config = {
    # this is an x86_64 linux machine :)
    nixpkgs.hostPlatform = lib.mkForce "x86_64-linux";

    boot = {
      extraModprobeConfig = ''
        options bbswitch load_state=-1 unload_state=1 nvidia-drm
      '';

      initrd = {
        availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
      };

      kernelModules = ["kvm-intel"];
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };

    hardware = {
      bluetooth = {
        enable = true;
        settings.General.Enable = "Source,Sink,Media,Socket";
      };

      nvidia = {
        nvidiaPersistenced = true;
        prime = {
          reverseSync.enable = true;
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
        };

        modesetting.enable = true;

        # Power management can cause issues with sleep. It's marked as experimental anyways
        # so lets just keep it off for now
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = false;
        nvidiaSettings = true;
        package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.production;
      };

      enableAllFirmware = true;
      cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      wirelessRegulatoryDatabase = true;

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    services.xserver.videoDrivers = ["intel" "nvidia"];
  };
}
