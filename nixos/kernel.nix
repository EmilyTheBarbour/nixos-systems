{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Only keep the last 5 configs present in the bootloader, no matter their age
  boot.loader.systemd-boot.configurationLimit = 5;
}
