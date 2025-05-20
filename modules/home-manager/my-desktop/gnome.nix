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
      document-font-name = "Noto Serif 11";
      font-name = "Noto Sans 10";
      monospace-font-name = "JetBrainsMono Nerd Font 10";
      scaling-factor = 2;
    };
    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      experimental-features = "['scale-monitor-framebuffer']";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = ["one.ablaze.floorp.desktop" "Alacritty.desktop" "org.gnome.Nautilus.desktop" "org.inkscape.Inkscape.desktop" "org.kde.krita.desktop"];
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
