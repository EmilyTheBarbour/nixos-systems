{pkgs, ...}: {
  home.packages = with pkgs; [
    # curently gimp2 is gimp; lets try some new stuff
    # also installs all of the current nixified gimp
    # plugins, cause why not
    gimp3-with-plugins
  ];
}
