{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:
# Don't tell the NixOS police, but I manually edited this file :)
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config = lib.mkMerge [
    {
      # this is an x86_64 linux machine :)
      nixpkgs.hostPlatform = lib.mkForce "x86_64-linux";

      boot = {
        extraModprobeConfig = ''
          options bbswitch load_state=-1 unload_state=1 nvidia-drm
        '';

        initrd = {
          availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
        };

        # TODO(emily): This isn't really good to do since the main display is ONLY connected
        # to the intel GPU
        # This basically forces ONLY The NVIDIA driver to work, which is fine and dandy but...
        # you can only use an external display...
        # kernelParams = [ "i915.modeset=0" ];
        # blacklistedKernelModules = [ "i915" ];

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
          prime = {
            nvidiaBusId = "PCI:1:0:0";
            intelBusId = "PCI:0:2:0";
          };

          # this causes graphical glitches occasionally on sleep for my machine
          nvidiaPersistenced = false;

          # TODO(emily): might also have to turn this off for hybrid GPU setup
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

      # TODO(emily): GNOME only uses an xWayland compatibility layer here, not true xserver.
      # Should investigate how to migrate to all wayland eventually

      # TODO(emily): Figure out how to handle this better without using xserver adapter
      # Order of eval via these udev rules unfortunately puts it after mutter loads,
      # meaning this doesn't take
      # # https://discourse.nixos.org/t/issues-with-nvidia-prime-sync-on-wayland/57546/23
      # services.udev.extraRules = ''
      #   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TAG+="mutter-device-preferred-primary"
      # '';
    }

    (lib.mkIf config.machine.dell-precision-5690.disable-intel {
      boot = {
        kernelParams = ["i915.modeset=0"];
        blacklistedKernelModules = ["i915"];
      };
    })

    (lib.mkIf (!config.machine.dell-precision-5690.disable-intel) {
      services.xserver.enable = true;
      services.xserver.videoDrivers = ["intel" "nvidia"];

      hardware.nvidia.prime = {
        # reverseSync.enable = true;
        # offload = {
        #   enable = true;
        #   enableOffloadCmd = true;
        # };
        sync.enable = true;
      };

      hardware.nvidia.dynamicBoost.enable = true;

      # environment.systemPackages = with pkgs; [
      #   nvidia-offload
      # ];

      services.udev.packages = [
        (pkgs.writeTextFile {
          name = "mutter-nvidia-primary-gpu";
          # Vendor 0x10de, Class 0x03 = Any NVIDIA GPU
          text = ''
            ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TAG+="mutter-device-preferred-primary"
          ''; 
          destination = "/etc/udev/rules.d/61-mutter-nvidia-primary-gpu.rules";
        })
      ];
    })
  ];
}
