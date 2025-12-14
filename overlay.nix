# any patches that need to be applied alongside our
# unrealized modules
inputs: final: prev: {
  generate_clangd = final.callPackage ./pkgs/generate_clangd {};

  bottles = prev.bottles.override {removeWarningPopup = true;};

  nvidia-offload = final.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';

  # qt6 = inputs.nixpkgs-unstable.legacyPackages.${final.system}.qt6;
  # qt6Packages = inputs.nixpkgs-unstable.legacyPackages.${final.system}.qt6Packages;

  bolt-launcher = prev.bolt-launcher.override {enableRS3 = true;};

  gcc-python-pretty-printers = final.stdenvNoCC.mkDerivation {
    name = "gcc-python-pretty-printers";
    version = "13.2";
    src =
      (final.fetchgit {
        url = "https://gcc.gnu.org/git/gcc.git";
        sparseCheckout = ["libstdc++-v3/python"];
        hash = "sha256-3L+jQ2/IRs2gtQF4/n6JSbv+ImPjZ+Ru0IWfth6yh2s=";
      })
      + "/libstdc++-v3/python";

    dontConfigure = true;
    dontBuild = true;
    dontPatch = true;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/python
      cp -r $src/* $out/python
      runHook postInstall
    '';
  };
}
