{ ... }: {
  services.flatpak.update.onActivation = true;
  services.flatpak.packages = [
    "ca.desrt.dconf-editor"
    "com.github.tchx84.Flatseal"
    "org.gnome.Calculator"
    "org.gnome.Loupe"
    "org.gnome.baobab"
    "org.gnome.font-viewer"
    "org.inkscape.Inkscape"
    "org.mozilla.firefox"
    "org.onlyoffice.desktopeditors"
    "org.gnome.Calendar"
    "org.gnome.Evince"
    "org.gnome.Totem"
    "io.bassi.Amberol"
    "org.kde.krita"
    "org.kde.kdenlive"
    "org.videolan.VLC"
    "com.brave.Browser"
    "org.libreoffice.LibreOffice"
    "org.blender.Blender"
    "com.calibre_ebook.calibre"
  ];
}
