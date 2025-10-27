{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    generate_clangd
  ];

  home.file.".gdbinit".text = ''
    set debuginfod enabled on
    python
    import sys
    sys.path.insert(0, '${pkgs.gcc-python-pretty-printers}/python')
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)
  '';
}
