{config, ...}: {
  home.file.".local/share/flatpak/overrides/global".text = ''
    [Context]
    filesystems=/nix/store;~/.themes;~/.icons;xdg-data/fonts;xdg-config/gtk-4.0
    [Environment]
    GTK_THEME=${config.gtk.theme.name}
    ICON_THEME=${config.gtk.iconTheme.name}
    XCURSOR_THEME=${config.home.pointerCursor.name}
    XDG_DATA_HOME=$HOME/.local/share
  '';
}
