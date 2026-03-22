{lib, ...}: {
  programs.git = {
    enable = true;
    settings.user = {
      email = lib.mkDefault "emilythebarbour@gmail.com";
      name = lib.mkDefault "Emily Barbour";

      push.autoSetupRemote = true;
    };

    # TODO(emily): Figure out best approach here; was deprecated in 25.05 apparently
    signing.format = "openpgp";
  };

  home.shellAliases = {
    gsu = "git submodule update --init --recursive";
  };
}
