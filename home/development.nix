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
  ];
}