{
  config,
  pkgs,
  ...
}: let
  flavour = config.my-desktop.catppuccinFlavour;
  iconThemeName =
    if flavour == "latte"
    then "Tela-circle"
    else "Tela-circle-dark";
  gtkThemeName = "catppuccin-${flavour}-sky-standard";
  cursorThemeName = "catppuccin-${flavour}-sky-cursors";
in {
  home.sessionVariables.GTK_THEME = gtkThemeName;

  home.file = {
    ".themes".source = "${config.gtk.theme.package}/share/themes";
    ".icons/${iconThemeName}".source = "${config.gtk.iconTheme.package}/share/icons/${iconThemeName}";
    ".local/share/icons/${iconThemeName}".source = "${config.gtk.iconTheme.package}/share/icons/${iconThemeName}";
    ".icons/${cursorThemeName}".source = "${config.home.pointerCursor.package}/share/icons/${cursorThemeName}";
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  home.pointerCursor = {
    name = cursorThemeName;
    package =
      if flavour == "latte"
      then pkgs.catppuccin-cursors.latteSky
      else if flavour == "mocha"
      then pkgs.catppuccin-cursors.mochaSky
      else if flavour == "macchiato"
      then pkgs.catppuccin-cursors.macchiatoSky
      else if flavour == "frappe"
      then pkgs.catppuccin-cursors.frappeSky
      else pkgs.catppuccin-cursors.latteSky; # Fallback
    gtk.enable = true;
    x11.enable = true;
    size = config.my-desktop.cursorSize;
  };

  gtk = {
    enable = true;
    font = {
      name = config.my-desktop.fonts.sans.name;
      package = config.my-desktop.fonts.sans.package;
    };
    iconTheme = {
      name = iconThemeName;
      package = pkgs.tela-circle-icon-theme;
    };
    theme = {
      name = gtkThemeName;
      package = pkgs.catppuccin-gtk.override {
        accents = ["sky"];
        variant = flavour;
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "cursor-theme" = cursorThemeName;
      "icon-theme" = iconThemeName;
      "gtk-theme" = gtkThemeName;
    };
  };

  home.file.".local/share/flatpak/overrides/global".text = ''
    [Context]
    filesystems=/nix/store;~/.themes;~/.icons;xdg-data/fonts;xdg-config/gtk-4.0
    [Environment]
    GTK_THEME=${gtkThemeName}
    ICON_THEME=${iconThemeName}
    XCURSOR_THEME=${cursorThemeName}
    XDG_DATA_HOME=$HOME/.local/share
  '';
}
