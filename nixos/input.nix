{
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };
  
  services.libinput.enable = true;
  services.libinput.mouse.accelProfile = "flat";
}
