{pkgs, ...}: {
  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;
  services.blueman.enable = true;
  programs.dconf.enable = true;
  security.pam.services.swaylock = {};

  environment.systemPackages = with pkgs; [
    gsettings-desktop-schemas
    polkit-kde-agent
    libsecret
  ];

  xdg.autostart.enable = true;
  xdg.portal.enable = true;
  xdg.portal.config.preferred.default = [
    "gtk"
    "hyprland"
  ];
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
  ];
}
