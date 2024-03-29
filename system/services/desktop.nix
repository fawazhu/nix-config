{ pkgs, ... }: {
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      config = {
        preferred = {
          default = [
            "gtk"
            "hyprland"
          ];
        };
      };
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
    };
  };

  services.dbus.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = [
    pkgs.gsettings-desktop-schemas
  ];
}
