{
  config,
  pkgs,
  ...
}: {
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

  boot = {
    plymouth = {
      enable = true;
      theme = "catppuccin-${config.my-desktop.catppuccinFlavour}";
      themePackages = [(pkgs.catppuccin-plymouth.override {variant = config.my-desktop.catppuccinFlavour;})];
    };
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
