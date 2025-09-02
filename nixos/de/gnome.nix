{ config, lib, ... }: (lib.mkIf (config.de.type == "gnome") {
  services = {
    xserver.enable = true;

    # Even more basic using gnome, but honestly it has the best motion gestures for laptops in the NIX ecosystem IMO.
    # I should eventually move this into a more full-fledged module, but practically all my dconf settings are
    # home-manager configured ATM anyways so /shrug
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
})
