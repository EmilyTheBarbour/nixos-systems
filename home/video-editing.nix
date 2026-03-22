{pkgs, ...}: {
  home.packages = with pkgs; [
    # kdePackages.kdenlive
    vlc
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      looking-glass-obs
      obs-advanced-masks
      # obs-color-monitor
      obs-dvd-screensaver
      obs-composite-blur
      obs-markdown
      obs-media-controls
      obs-recursion-effect
      obs-replay-source
      obs-retro-effects
      obs-rgb-levels
      obs-scale-to-sound
      obs-source-record
      # obs-urlsource
      obs-vkcapture
      obs-vnc
      wlrobs
    ];
  };
}
