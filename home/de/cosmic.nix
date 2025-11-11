{lib, pkgs, ...}: {
  programs.firefox.policies.Preferences = {
    "widget.gtk.libadwaita-colors.enabled" = false;
  };

  home.file = 
    let folders = 
      let 
        wallpaper = "${../../config/wallpaper.jpg}";
      in
      {
      # wallpapers stuffs
      "com.system76.CosmicBackground/v1/same-on-all" = pkgs.writeText "same-on-all" ''
        true        
      '';
      "com.system76.CosmicBackground/v1/all" = pkgs.writeText "all" ''
        (
            output: "all",
            source: Path("${wallpaper}"),
            filter_by_theme: true,
            rotation_frequency: 300,
            filter_method: Lanczos,
            scaling_mode: Zoom,
            sampling_method: Alphanumeric,
        )
      '';
      "com.system76.CosmicSettings.Wallpaper/v1/custom-images" = pkgs.writeText "custom-images" ''
        [
          "${wallpaper}",
        ]
        '';
        
      "com.system76.CosmicAppList" = ../../config/cosmic/com.system76.CosmicAppList;
      "com.system76.CosmicComp" = ../../config/cosmic/com.system76.CosmicComp;
      "com.system76.CosmicPanel" = ../../config/cosmic/com.system76.CosmicPanel;
      "com.system76.CosmicPanel.Dock" = ../../config/cosmic/com.system76.CosmicPanel.Dock;
      "com.system76.CosmicPanel.Panel" = ../../config/cosmic/com.system76.CosmicPanel.Panel;
      "com.system76.CosmicSettings.Shortcuts" = ../../config/cosmic/com.system76.CosmicSettings.Shortcuts;
      "com.system76.CosmicTheme.Dark" = ../../config/cosmic/com.system76.CosmicTheme.Dark;
      "com.system76.CosmicTheme.Dark.Builder" = ../../config/cosmic/com.system76.CosmicTheme.Dark.Builder;
      "com.system76.CosmicTheme.Light" = ../../config/cosmic/com.system76.CosmicTheme.Light;
      "com.system76.CosmicTheme.Light.Builder" = ../../config/cosmic/com.system76.CosmicTheme.Light.Builder;
      "com.system76.CosmicTk" = ../../config/cosmic/com.system76.CosmicTk;
    };
    inherit (lib.attrsets) nameValuePair;
  in lib.mapAttrs' (name: path: nameValuePair (".config/cosmic/${name}") ({
    enable = true;
    source = path;
    recursive = true;
    force = true;
  })) folders;
}