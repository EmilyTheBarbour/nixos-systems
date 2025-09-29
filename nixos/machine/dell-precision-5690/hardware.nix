{
  config,
  lib,
  modulesPath,
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

      # This basically forces ONLY The NVIDIA driver to work, which is fine and dandy but...
      # you can only use an external display...
      kernelParams = [ "i915.modeset=0" ];
      blacklistedKernelModules = [ "i915" ];

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
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
          sync.enable = true;
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

    # https://discourse.nixos.org/t/issues-with-nvidia-prime-sync-on-wayland/57546/23
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TAG+="mutter-device-preferred-primary"
    '';
  };
}
