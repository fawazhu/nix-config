{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Sky-Dark";
  };

  home.file = {
    ".themes".source = "${config.gtk.theme.package}/share/themes";
    ".icons/Tela-circle".source = "${config.gtk.iconTheme.package}/share/icons/Tela-circle";
    ".local/share/icons/Tela-circle".source = "${config.gtk.iconTheme.package}/share/icons/Tela-circle";
    ".icons/Catppuccin-Mocha-Sky-Cursors".source = "${config.home.pointerCursor.package}/share/icons/Catppuccin-Mocha-Sky-Cursors";
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  home.pointerCursor = {
    name = "Catppuccin-Mocha-Sky-Cursors";
    package = pkgs.catppuccin-cursors.mochaSky;
    gtk.enable = true;
    x11.enable = true;
    size = 32;
  };

  gtk = {
    enable = true;
    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
    };
    iconTheme = {
      name = "Tela-circle";
      package = pkgs.tela-circle-icon-theme;
    };
    theme = {
      name = "Catppuccin-Mocha-Standard-Sky-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["sky"];
        variant = "mocha";
      };
    };
  };
}
