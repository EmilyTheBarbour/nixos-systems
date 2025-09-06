{ parameters, config, ... }: {
  networking.hostName = "personal-pc";
  networking.networkmanager.enable = true;
  users.users.${parameters.users.main-user.user-name}.extraGroups = [ "networkmanager" ];

  services.openssh.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hardware-Config.nix follows below
  nixpkgs.hostPlatform = "x86_64-linux";
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  networking.useDHCP = true;

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  ardware.graphics.enable = true;
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

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.xserver.libinput.enable = true;
  services.xserver.libinput.mouse.accelProfile = "flat";

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
}
