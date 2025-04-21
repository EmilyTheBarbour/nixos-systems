{lib, ...}: {
  programs.git = {
    enable = true;
    userEmail = lib.mkDefault "emilythebarbour@gmail.com";
    userName = lib.mkDefault "Emily Barbour";
  };
}
