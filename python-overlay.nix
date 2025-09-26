# any patches that need to be applied alongside our
# unrealized modules
final: prev: {
  generate_clangd = final.callPackage ./pkgs/generate_clangd {};
}
