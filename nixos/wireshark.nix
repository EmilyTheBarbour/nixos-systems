{
  pkgs,
  parameters,
  ...
}: {
  programs.wireshark = {
    enable = true;
    usbmon.enable = true;
    package = pkgs.wireshark;
  };
  users.users.${parameters.users.main-user.user-name}.extraGroups = ["wireshark"];
}
