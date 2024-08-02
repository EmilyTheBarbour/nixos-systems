{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    # define this as a NixOS System
    self.nixosModules.default

    # Select GPU Hardware
    ../nixos/system/nvidia.nix
    
    # Select Desktop Environment
    ../nixos/de/gnome.nix
    # ../nixos/de/sway.nix
  ];

  # Define the identifies for this system
  nixos-flake.sshTarget = "emily@personal-pc";
  system.stateVersion = "24.05"; 
  
  # Configure Networking
  networking.hostName = "personal-pc";
  networking.networkmanager.enable = true;
  users.users.${flake.config.people.myself}.extraGroups = [ "networkmanager" "wheel" ];

  # enable ssh
  services.openssh.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hardware-Config.nix follows below
  nixpkgs.hostPlatform = "x86_64-linux";
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/dbc71064-c4f8-47be-9598-cb70a9372d7c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/7EC9-C87C";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];

  networking.useDHCP = inputs.nixpkgs.lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}
