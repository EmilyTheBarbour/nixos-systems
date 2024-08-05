{pkgs, ...}: {
  home.packages = with pkgs; [
    # rust development tools
    cargo

    # C Development Tools
    llvm
    cmake
    
    # Misc Tools
    cntr
    kcachegrind
    jq
    ripgrep

    # cool nix tools
    manix
    nix-melt
    nix-diff
    nix-output-monitor
    nix-tree
    nix-health
  ];
}