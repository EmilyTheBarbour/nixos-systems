{lib, ...}: {
  programs.git = {
    enable = true;
    settings.user = {
      email = lib.mkDefault "emilythebarbour@gmail.com";
      name = lib.mkDefault "Emily Barbour";

      push.autoSetupRemote = true;
    };
  };

  home.shellAliases = {
    gsu = "git submodule update --init --recursive";
  };
}
