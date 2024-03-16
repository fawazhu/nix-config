{ config, pkgs, ... }: {
  home.sessionVariables = {
    GTK_THEME = "Catppuccin-Latte-Standard-Sky-Light";
  };

  home.file = {
    ".themes".source = "${config.gtk.theme.package}/share/themes";
    ".icons/Tela-circle".source = "${config.gtk.iconTheme.package}/share/icons/Tela-circle";
    ".local/share/icons/Tela-circle".source = "${config.gtk.iconTheme.package}/share/icons/Tela-circle";
    ".icons/Catppuccin-Latte-Sky-Cursors".source = "${config.home.pointerCursor.package}/share/icons/Catppuccin-Latte-Sky-Cursors";
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  home.pointerCursor = {
    name = "Catppuccin-Latte-Sky-Cursors";
    package = pkgs.catppuccin-cursors.latteSky;
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
#   cursorTheme = {
#        name = "Catppuccin-Latte-Sky-Cursors";
#        package = pkgs.catppuccin-cursors.latteSky;
#    };
    iconTheme = {
      name = "Tela-circle";
      package = pkgs.tela-circle-icon-theme;
    };
    theme = {
      name = "Catppuccin-Latte-Standard-Sky-Light";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "sky" ];
	    variant = "latte";
      };
    };
  };
}
