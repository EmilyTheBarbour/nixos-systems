{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gdb
  ];

  services.nixseparatedebuginfod2.enable = true;
}
