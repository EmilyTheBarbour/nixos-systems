{parameters, ...}: {
  networking.hostName = parameters.machine.name;
  networking.networkmanager.enable = true;
  users.users.${parameters.users.main-user.user-name}.extraGroups = ["networkmanager"];

  services.openssh.enable = true;
}
