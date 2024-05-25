{...}: {
  imports = [../../modules/home-manager/my-desktop];

  home.username = "guest";
  home.homeDirectory = "/home/guest";

  services.flatpak.packages = [ "org.gnome.TextEditor//stable" ];

  my-desktop = {
    enable = true;
    catppuccinFlavour = "latte";
    scaleFactor = "1.25";
    cursorSize = 32;
    services.kdeconnect.enable = false;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
