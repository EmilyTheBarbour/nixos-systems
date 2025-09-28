{
  dconf.settings = {
    "org/gnome/desktop/background" = let wp-uri = "file://${../../../config/wallpaper.jpg}"; in {
      color-shading-type = "solid";
      picture-uri = wp-uri;
      picture-uri-dark = wp-uri;
    };
    "org/gnome/screensaver" = let wp-uri = "file://${../../../config/lockscreen.jpg}"; in {
      picture-uri = wp-uri;
    };
  };

}
