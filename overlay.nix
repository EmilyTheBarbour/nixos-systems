# any patches that need to be applied alongside our
# unrealized modules
final: prev: {
  generate_clangd = final.callPackage ./pkgs/generate_clangd {};

  bottles = prev.bottles.override {removeWarningPopup = true;};

  nvidia-offload = final.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
}
