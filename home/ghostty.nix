{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
    };
  };

  # Ghostty is weirdly dependant on it also being installed
  # on remote hosts; this basically forces Ghostty to fall
  # back to a limited feature set on any remote host connection
  programs.ssh.matchBlocks."*" = {
    setEnv = {
      "TERM" = "xterm-256color";
    };
  };
}
