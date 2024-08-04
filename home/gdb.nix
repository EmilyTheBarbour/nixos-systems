{pkgs, config, lib, ...}:
let 
  pretty-printers = pkgs.stdenvNoCC.mkDerivation {
    name = "gcc-python-pretty-printers";
    version = "13.2";
    src = (pkgs.fetchgit {
      url = "https://gcc.gnu.org/git/gcc.git";
      sparseCheckout = ["libstdc++-v3/python"];
      hash = "sha256-K1AwX+NTKh4Lm1V5l82pE2VyToMiRiJGk+/MLdhifd0=";
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
  
  url = "127.0.0.1:1949";
in
{
  home.packages = with pkgs; [
    gdb
  ];
  
  home.file.".gdbinit".text = ''
    set debuginfod enabled on
    python
    import sys
    sys.path.insert(0, '${pretty-printers}/python')
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)
  '';
  
  home.sessionVariables = {
    DEBUGINFOD_URLS = "https://${url}";
  };
  
  systemd.user.services.nixseparatedebuginfod = {
    Unit = {
      Description = "Download and provide seperate debuginfo via the nix store";
    };
    
    Install.WantedBy = ["default.target"];
    Service = {
      Environment = "PATH=${lib.makeBinPath [pkgs.nix]}";
      Restart = "on-failure";
      ExecStart = "${pkgs.nixseparatedebuginfod}/bin/nixseparatedebuginfod -l ${url}";
    };
  };
}