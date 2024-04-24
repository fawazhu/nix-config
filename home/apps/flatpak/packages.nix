{...}: {
  services.flatpak.update.onActivation = true;
  services.flatpak.packages = [
    "ca.desrt.dconf-editor//stable"
    "com.github.tchx84.Flatseal//stable"
    "org.gnome.Calculator//stable"
    "org.gnome.Loupe//stable"
    "org.gnome.baobab//stable"
    "org.gnome.font-viewer//stable"
    "org.inkscape.Inkscape//stable"
    "org.mozilla.firefox//stable"
    "org.onlyoffice.desktopeditors//stable"
    "org.gnome.Calendar//stable"
    "org.gnome.Evince//stable"
    "org.gnome.Totem//stable"
    "io.bassi.Amberol//stable"
    "org.kde.krita//stable"
    "org.kde.kdenlive//stable"
    "org.videolan.VLC//stable"
    "com.brave.Browser//stable"
    "org.libreoffice.LibreOffice//stable"
    "org.blender.Blender//stable"
    "com.calibre_ebook.calibre//stable"
  ];
}
