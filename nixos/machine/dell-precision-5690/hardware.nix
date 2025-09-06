{
  config,
  lib,
  modulesPath,
  pkgs,
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
      # I like to live on the edge, and it made my camera work slightly better
      kernelPackages = pkgs.linuxPackages_latest;

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
          sync.enable = true;
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
        };

        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
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

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      # TODO(Emily): Current Unstable has segfaults with our camera, even if we disable our ./camera.nix file...
      # this really should be fixed...
      package = inputs.nixpkgs-24-11.legacyPackages.x86_64-linux.pipewire;
      wireplumber.package = inputs.nixpkgs-24-11.legacyPackages.x86_64-linux.wireplumber;
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
