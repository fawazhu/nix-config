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

  lightWallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/1.png";
  darkWallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/2.png";
  wallpaper =
    if isLight
    then lightWallpaper
    else darkWallpaper;

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
    "org/gnome/desktop/background" = {
      picture-uri = "file://${lightWallpaper}";
      picture-uri-dark = "file://${darkWallpaper}";
    };
    "org/gnome/desktop/interface" = {
      accent-color = gnomeAccent;
      color-scheme =
        if isLight
        then "prefer-light"
        else "prefer-dark";
    };
    "org/gnome/mutter" = {
      experimental-features = "['scale-monitor-framebuffer']";
    };
  };

  programs.gnome-shell.extensions = with pkgs.gnomeExtensions; (
    if isLight
    then [
      {
        id = light-style.extensionUuid;
        package = light-style;
      }
    ]
    else []
  );

  services.hyprpaper.settings = {
    preload = [wallpaper];
    wallpaper = [",${wallpaper}"];
  };

  wayland.windowManager.hyprland.settings = {
    env = ["GDK_SCALE,${toString scaling}"];
    exec-once = ["hyprpaper"];
    monitor = ",highres,auto,${toString scaling}";
    xwayland.force_zero_scaling = true;

    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      "col.active_border" = "rgba(${hex}ff)";
      "col.inactive_border" = "rgba(${hex}ff)";
    };
    decoration.rounding = 10;
    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };
    misc.disable_hyprland_logo = true;
  };

  xdg.dataFile."rofi/themes".source = "${pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "rofi";
    rev = "b636a00fd40a7899a8206195464ae8b7f0450a6d";
    sha256 = "sha256-zA8Zum19pDTgn0KdQ0gD2kqCOXK4OCHBidFpGwrJOqg=";
  }}/basic/.local/share/rofi/themes";

  xdg.configFile."rofi/config.rasi".text = ''
    configuration{
      modi: "run,drun,window";
      icon-theme: "${iconThemeName}";
      show-icons: true;
      terminal: "alacritty";
      drun-display-format: "{icon} {name}";
      location: 0;
      disable-history: false;
      hide-scrollbar: true;
      display-drun: "   Apps ";
      display-run: "   Run ";
      display-window: "   Window ";
      sidebar-mode: true;
    }

    @theme "catppuccin-${flavour}"

    * {
      blue: #${hex};
    }
  '';

  programs.swaylock.settings = with (builtins.getAttr flavour palette).colors; {
    ignore-empty-password = true;
    hide-keyboard-layout = true;
    disable-caps-lock-text = true;
    color = builtins.substring 1 (-1) base.hex;
    bs-hl-color = builtins.substring 1 (-1) rosewater.hex;
    caps-lock-bs-hl-color = builtins.substring 1 (-1) rosewater.hex;
    caps-lock-key-hl-color = builtins.substring 1 (-1) green.hex;
    inside-color = "00000000";
    inside-clear-color = "00000000";
    inside-caps-lock-color = "00000000";
    inside-ver-color = "00000000";
    inside-wrong-color = "00000000";
    key-hl-color = builtins.substring 1 (-1) green.hex;
    layout-bg-color = "00000000";
    layout-border-color = "00000000";
    layout-text-color = builtins.substring 1 (-1) text.hex;
    line-color = "00000000";
    line-clear-color = "00000000";
    line-caps-lock-color = "00000000";
    line-ver-color = "00000000";
    line-wrong-color = "00000000";
    ring-color = builtins.substring 1 (-1) lavender.hex;
    ring-clear-color = builtins.substring 1 (-1) rosewater.hex;
    ring-caps-lock-color = builtins.substring 1 (-1) peach.hex;
    ring-ver-color = builtins.substring 1 (-1) blue.hex;
    ring-wrong-color = builtins.substring 1 (-1) maroon.hex;
    separator-color = "00000000";
    text-color = builtins.substring 1 (-1) text.hex;
    text-clear-color = builtins.substring 1 (-1) rosewater.hex;
  };

  xdg.configFile = {
    "swaync/style.css".text = with (builtins.getAttr flavour palette).colors; ''
      * {
        all: unset;
        font-size: 14px;
        font-family: JetBrainsMono Nerd Font;
        transition: 200ms;
      }

      trough highlight {
        background: ${text.hex};
      }

      scale trough {
        margin: 0rem 1rem;
        background-color: ${surface0.hex};
        min-height: 8px;
        min-width: 70px;
      }

      slider {
        background-color: ${blue.hex};
      }

      .floating-notifications.background .notification-row .notification-background {
        box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px ${surface0.hex};
        border-radius: 12.6px;
        margin: 18px;
        background-color: ${surface0.hex};
        color: ${text.hex};
        padding: 0;
      }

      .floating-notifications.background .notification-row .notification-background .notification {
        padding: 7px;
        border-radius: 12.6px;
      }

      .floating-notifications.background .notification-row .notification-background .notification.critical {
        box-shadow: inset 0 0 7px 0 ${red.hex};
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content {
        margin: 7px;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
        color: ${text.hex};
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
        color: ${subtext0.hex};
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
        color: ${text.hex};
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
        border-radius: 7px;
        color: ${text.hex};
        background-color: ${surface0.hex};
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        margin: 7px;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        background-color: ${surface0.hex};
        color: ${text.hex};
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        background-color: ${sapphire.hex};
        color: ${text.hex};
      }

      .floating-notifications.background .notification-row .notification-background .close-button {
        margin: 7px;
        padding: 2px;
        border-radius: 6.3px;
        color: ${base.hex};
        background-color: ${red.hex};
      }

      .floating-notifications.background .notification-row .notification-background .close-button:hover {
        background-color: ${maroon.hex};
        color: ${base.hex};
      }

      .floating-notifications.background .notification-row .notification-background .close-button:active {
        background-color: ${red.hex};
        color: ${base.hex};
      }

      .control-center {
        box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px ${surface0.hex};
        border-radius: 12.6px;
        margin: 18px;
        background-color: ${base.hex};
        color: ${text.hex};
        padding: 14px;
      }

      .control-center .widget-title > label {
        color: ${text.hex};
        font-size: 1.3em;
      }

      .control-center .widget-title button {
        border-radius: 7px;
        color: ${text.hex};
        background-color: ${surface0.hex};
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        padding: 8px;
      }

      .control-center .widget-title button:hover {
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        background-color: ${surface2.hex};
        color: ${text.hex};
      }

      .control-center .widget-title button:active {
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        background-color: ${sapphire.hex};
        color: ${base.hex};
      }

      .control-center .notification-row .notification-background {
        border-radius: 7px;
        color: ${text.hex};
        background-color: ${surface0.hex};
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        margin-top: 14px;
      }

      .control-center .notification-row .notification-background .notification {
        padding: 7px;
        border-radius: 7px;
      }

      .control-center .notification-row .notification-background .notification.critical {
        box-shadow: inset 0 0 7px 0 ${red.hex};
      }

      .control-center .notification-row .notification-background .notification .notification-content {
        margin: 7px;
      }

      .control-center .notification-row .notification-background .notification .notification-content .summary {
        color: ${text.hex};
      }

      .control-center .notification-row .notification-background .notification .notification-content .time {
        color: ${subtext0.hex};
      }

      .control-center .notification-row .notification-background .notification .notification-content .body {
        color: ${text.hex};
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
        border-radius: 7px;
        color: ${text.hex};
        background-color: ${crust.hex};
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        margin: 7px;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        background-color: ${surface0.hex};
        color: ${text.hex};
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        background-color: ${sapphire.hex};
        color: ${text.hex};
      }

      .control-center .notification-row .notification-background .close-button {
        margin: 7px;
        padding: 2px;
        border-radius: 6.3px;
        color: ${base.hex};
        background-color: ${maroon.hex};
      }

      .close-button {
        border-radius: 6.3px;
      }

      .control-center .notification-row .notification-background .close-button:hover {
        background-color: ${red.hex};
        color: ${base.hex};
      }

      .control-center .notification-row .notification-background .close-button:active {
        background-color: ${red.hex};
        color: ${base.hex};
      }

      .control-center .notification-row .notification-background:hover {
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        background-color: ${overlay1.hex};
        color: ${text.hex};
      }

      .control-center .notification-row .notification-background:active {
        box-shadow: inset 0 0 0 1px ${surface1.hex};
        background-color: ${sapphire.hex};
        color: ${text.hex};
      }

      .notification.critical progress {
        background-color: ${red.hex};
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: ${blue.hex};
      }

      .control-center-dnd {
        margin-top: 5px;
        border-radius: 8px;
        background: ${surface0.hex};
        border: 1px solid ${surface1.hex};
        box-shadow: none;
      }

      .control-center-dnd:checked {
        background: ${surface0.hex};
      }

      .control-center-dnd slider {
        background: ${surface1.hex};
        border-radius: 8px;
      }

      .widget-dnd {
        margin: 0px;
        font-size: 1.1rem;
      }

      .widget-dnd > switch {
        font-size: initial;
        border-radius: 8px;
        background: ${surface0.hex};
        border: 1px solid ${surface1.hex};
        box-shadow: none;
      }

      .widget-dnd > switch:checked {
        background: ${surface0.hex};
      }

      .widget-dnd > switch slider {
        background: ${surface1.hex};
        border-radius: 8px;
        border: 1px solid ${overlay0.hex};
      }

      .widget-mpris .widget-mpris-player {
        background: ${surface0.hex};
        padding: 7px;
      }

      .widget-mpris .widget-mpris-title {
        font-size: 1.2rem;
      }

      .widget-mpris .widget-mpris-subtitle {
        font-size: 0.8rem;
      }

      .widget-menubar > box > .menu-button-bar > button > label {
        font-size: 3rem;
        padding: 0.5rem 2rem;
      }

      .widget-menubar > box > .menu-button-bar > :last-child {
        color: ${red.hex};
      }

      .power-buttons button:hover,
      .powermode-buttons button:hover,
      .screenshot-buttons button:hover {
        background: ${surface0.hex};
      }

      .control-center .widget-label > label {
        color: ${text.hex};
        font-size: 2rem;
      }

      .widget-buttons-grid {
        padding-top: 1rem;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button label {
        font-size: 2.5rem;
      }

      .widget-volume {
        padding-top: 1rem;
      }

      .widget-volume label {
        font-size: 1.5rem;
        color: ${sapphire.hex};
      }

      .widget-volume trough highlight {
        background: ${sapphire.hex};
      }

      .widget-backlight trough highlight {
        background: ${yellow.hex};
      }

      .widget-backlight scale {
        margin-right: 1rem;
      }

      .widget-backlight label {
        font-size: 1.5rem;
        color: ${yellow.hex};
      }

      .widget-backlight .KB {
        padding-bottom: 1rem;
      }
    '';
    "waybar/themes".source = "${pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "waybar";
      rev = "v1.1";
      sha256 = "sha256-9lY+v1CTbpw2lREG/h65mLLw5KuT8OJdEPOb+NNC6Fo=";
    }}/themes";
    "waybar/theme.css".text = ''
      @import "themes/${flavour}.css";
      @define-color accent #${hex};
    '';
    "starship.toml".text = ''
      add_newline = true
      [directory]
      style = '#${hex}'
      [character]
      success_symbol = '[❯](#${hex})'
      vimcmd_symbol = '[❮](#${hex})'
    '';
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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-theme = cursorThemeName;
      icon-theme = iconThemeName;
      gtk-theme = gtkThemeName;
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
