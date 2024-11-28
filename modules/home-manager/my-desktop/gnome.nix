{
  config,
  pkgs,
  ...
}: {
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "file://${config.home.homeDirectory}/Pictures/Wallpapers/1.png";
      picture-uri-dark = "file://${config.home.homeDirectory}/Pictures/Wallpapers/2.png";
    };
    "org/gnome/desktop/interface" = {
      accent-color = "teal";
      color-scheme =
        if config.my-desktop.catppuccinFlavour == "latte"
        then "prefer-light"
        else "prefer-dark";
      font-antialiasing = "rgba";
      document-font-name = "${config.my-desktop.fonts.serif.name} 11";
      font-name = "${config.my-desktop.fonts.sans.name} 10";
      monospace-font-name = "${config.my-desktop.fonts.mono.name} 10";
      scaling-factor = 1.25;
    };
    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      experimental-features = "['scale-monitor-framebuffer']";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = ["org.mozilla.firefox.desktop" "Alacritty.desktop" "org.gnome.Nautilus.desktop" "org.inkscape.Inkscape.desktop" "org.kde.krita.desktop"];
    };
  };
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions;
      [
        {
          id = clipboard-indicator.extensionUuid;
          package = clipboard-indicator;
        }
      ]
      ++ (
        if config.my-desktop.catppuccinFlavour == "latte"
        then [
          {
            id = light-style.extensionUuid;
            package = light-style;
          }
        ]
        else []
      );
  };
}
