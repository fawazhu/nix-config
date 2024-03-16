{ pkgs, ... }: {
  xdg.configFile = {
    "hypr/hyprpaper.conf".text = ''
      preload = ~/Pictures/Wallpapers/1.png
      wallpaper = ,~/Pictures/Wallpapers/1.png

      ipc = off
      splash = true
    '';
  };

  home.packages = [ pkgs.hyprpaper ];
}
