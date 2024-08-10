{
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };
  
  services.xserver.libinput.enable = true;
  services.xserver.libinput.mouse.accelProfile = "flat";
}
