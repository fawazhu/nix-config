{pkgs, ...}: {
  services.gnome.gnome-keyring.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb.layout = "gb";
  programs.dconf.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  environment.systemPackages = with pkgs; [
    gsettings-desktop-schemas
    libsecret
  ];
  environment.gnome.excludePackages = with pkgs; [
    baobab
    epiphany
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-weather
    loupe
    gnome-connections
    simple-scan
    snapshot
    totem
    yelp
    gnome-software
    evince
    geary
    gnome-disk-utility
    seahorse
    sushi
  ];

  xdg.autostart.enable = true;
}
