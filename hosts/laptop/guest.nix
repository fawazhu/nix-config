{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/my-apps
    ../../modules/home-manager/my-desktop
  ];

  home.username = "guest";
  home.homeDirectory = "/home/guest";

  my-apps = {
    enable = true;
    catppuccinFlavour = "latte";
    alacritty.enable = true;
    packages = with pkgs; [
      seahorse
      nautilus
      file-roller
      gparted
    ];
    flatpak.packages = [
      "org.gnome.Calculator//stable"
      "org.gnome.Loupe//stable"
      "org.mozilla.firefox//stable"
      "org.onlyoffice.desktopeditors//stable"
      "org.gnome.Calendar//stable"
      "org.gnome.Evince//stable"
      "org.gnome.Totem//stable"
      "org.gnome.TextEditor//stable"
      "io.bassi.Amberol//stable"
      "org.videolan.VLC//stable"
      "com.brave.Browser//stable"
      "org.libreoffice.LibreOffice//stable"
    ];
    mimeDefaults = {
      enable = true;
      archive = "org.gnome.FileRoller.desktop";
      browser = "org.mozilla.firefox.desktop";
      calendar = "com.calibre_ebook.calibre.desktop";
      document = "org.libreoffice.LibreOffice.desktop";
      ebook = "";
      font = "";
      editor = "org.gnome.TextEditor.desktop";
      image = "org.gnome.Loupe.desktop";
      music = "io.bassi.Amberol.desktop";
      pdf = "org.gnome.Evince.desktop";
      video = "org.gnome.Totem.desktop";
    };
  };
  my-desktop = {
    enable = true;
    catppuccinFlavour = "latte";
    scaleFactor = "1.25";
    cursorSize = 32;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
