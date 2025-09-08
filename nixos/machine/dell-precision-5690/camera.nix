{ config
, pkgs
, lib
, ...
}:
let cfg = config.machine.dell-precision-5690; in {
  config = (lib.mkIf (cfg.enable-camera-config) lib.trace "enabling experimental 5690 camera support" {
    #TODO(Emily): Currently this is semi-working via pipewire. However, Video through pipewire is still rather new,
    # and as such many services don't have correct integrations, i.e zoom.
    #
    # Notably, V4L is NOT Currently working with this config. Given that, a minimum viable config is to probably to a
    # pipewire -> V4L loopback device via some pipewire config, but that still needs to be done.

    boot = {
      # Ensure the correct kernel module for the 5690 camera is loaded at boot time
      kernelModules = [ "intel_ipu6" ];

      # Ensure we properly include the kernel module to interface with our 5690 camera
      extraModulePackages = with config.boot.kernelPackages; [ ipu6-drivers ];
    };

    # TODO(emily): Make this a dev-shell for testing, required modules to use our
    # camera Kernel Driver with gstreamer
    environment.systemPackages = with pkgs.gst_all_1; [
      # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
      gstreamer
      # Common plugins like "filesrc" to combine within e.g. gst-launch
      gst-plugins-base
      # Specialized plugins separated by quality
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      # Plugins to reuse ffmpeg to play almost every video format
      gst-libav
      # Support the Video Audio (Hardware) Acceleration API
      gst-vaapi

      icamerasrc-ipu6
    ];

    hardware = {
      graphics = {
        # Additional packages adapting our kernel driver for 5690 camera support
        extraPackages = with pkgs; [
          intel-media-driver
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    };
  });
}
