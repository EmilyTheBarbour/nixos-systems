{parameters, pkgs, ...}: {
  # Gives the main user access to gphoto2 mounted devices
  users.users.${parameters.users.main-user.user-name}.extraGroups = [
    "camera"
  ];

  # Automount, camera utilities
  programs.gphoto2.enable = true;

  environment.systemPackages = with pkgs; [
    # RAW Photo editing
    darktable
    
    # Mount Camera file-system as a volume
    gphoto2fs
  ];
}