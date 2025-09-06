{
  pkgs,
  parameters,
  ...
}: {
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
  users.users.${parameters.users.main-user.user-name}.extraGroups = ["wireshark"];
}
