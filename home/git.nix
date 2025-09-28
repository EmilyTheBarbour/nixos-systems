{lib, ...}: {
  programs.git = {
    enable = true;
    userEmail = lib.mkDefault "emilythebarbour@gmail.com";
    userName = lib.mkDefault "Emily Barbour";

    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
    };
  };

  home.shellAliases = {
    gsu = "git submodule update --init --recursive";
  };
}
