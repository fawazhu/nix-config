{
  config,
  lib,
  pkgs,
  ...
}: let
  flavour = config.theming.flavour;
  accent = config.theming.accent;
  scaling = config.theming.scaling;

  captializedAccent = (lib.toUpper (builtins.substring 0 1 accent)) + (builtins.substring 1 (-1) accent);
  hex = builtins.substring 1 (-1) ((builtins.getAttr accent (builtins.getAttr flavour palette).colors).hex);
  palette = builtins.fromJSON (builtins.readFile ./palette.json);

  isLight = ! (builtins.getAttr flavour palette).dark;

  iconThemeSuffix =
    if isLight
    then "light"
    else "dark";
  iconThemeName = "Tela-circle-${hex}-${iconThemeSuffix}";
  iconThemePackage = pkgs.callPackage ./tela-circle-icon-theme.nix {hex = hex;};

  gtkThemeName = "catppuccin-${flavour}-${accent}-standard";
  gtkThemePackage = pkgs.catppuccin-gtk.override {
    accents = [accent];
    variant = flavour;
  };

  cursorThemeName = "catppuccin-${flavour}-${accent}-cursors";
  cursorThemePackage = builtins.getAttr "${flavour}${captializedAccent}" pkgs.catppuccin-cursors;

  gnomeAccent = builtins.getAttr accent {
    rosewater = "orange";
    flamingo = "red";
    pink = "pink";
    mauve = "purple";
    red = "red";
    maroon = "red";
    peach = "orange";
    yellow = "yellow";
    green = "green";
    teal = "teal";
    sky = "blue";
    sapphire = "blue";
    blue = "blue";
    lavender = "blue";
  };
in {
  programs.plasma.configFile = {
    #"kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" = "${wallpaper}";
    #"kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."PreviewImage" = "${wallpaper}";
    "kcminputrc"."Mouse"."cursorTheme" = "catppuccin-${flavour}-${accent}-cursors";
    "kdeglobals"."Icons"."Theme" = "${iconThemeName}";
    "kwinrc"."Xwayland"."Scale" = scaling;
    #"plasmarc"."Wallpapers"."usersWallpapers" = "${wallpaper}";
  };
  home.packages = [
    (pkgs.catppuccin-kde.override {
      flavour = [flavour];
      accents = [accent];
    })
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      accent-color = gnomeAccent;
      color-scheme =
        if isLight
        then "prefer-light"
        else "prefer-dark";
      cursor-theme = cursorThemeName;
      icon-theme = iconThemeName;
      gtk-theme = gtkThemeName;
    };
  };
  home.sessionVariables.GTK_THEME = gtkThemeName;

  home.file = {
    ".themes".source = "${gtkThemePackage}/share/themes";
    ".icons/${iconThemeName}".source = "${iconThemePackage}/share/icons/${iconThemeName}";
    ".local/share/icons/${iconThemeName}".source = "${iconThemePackage}/share/icons/${iconThemeName}";
    ".icons/${cursorThemeName}".source = "${cursorThemePackage}/share/icons/${cursorThemeName}";
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${gtkThemePackage}/share/themes/${gtkThemeName}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${gtkThemePackage}/share/themes/${gtkThemeName}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${gtkThemePackage}/share/themes/${gtkThemeName}/gtk-4.0/gtk-dark.css";
  };

  home.pointerCursor = {
    name = cursorThemeName;
    package = cursorThemePackage;
    gtk.enable = true;
    x11.enable = true;
    size = 32;
  };

  gtk = {
    enable = true;
    gtk2.force = true;
    font.name = "Noto Sans";
    iconTheme = {
      name = iconThemeName;
      package = iconThemePackage;
    };
    theme = {
      name = gtkThemeName;
      package = gtkThemePackage;
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
