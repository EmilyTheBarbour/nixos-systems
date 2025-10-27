{ parameters, ... }: {
  nix = {
    # Run every other week, and remove paths older than 3 weeks
    gc = {
      automatic = true;
      dates = "*-*-1,14,28 00:00:00";
      options = "--delete-older-than 21d";
    };

    # work requires 2.18 exactly due to the hashing algorithm delta
    # from newer versions...
    #
    # This is a workaround due to 2.18 currently being deprecated in
    # unstable
    settings = {
      auto-optimise-store = true;
      extra-experimental-features = [ "flakes" "nix-command" ];
      keep-outputs = true;
      keep-derivations = true;
      trusted-users = [ parameters.users.main-user.user-name ];
      system-features = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    };
  };

  # I'm not a FOSS Evangelist, I just need tools that work
  nixpkgs.config.allowUnfree = true;

  # required for rs3
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
}
