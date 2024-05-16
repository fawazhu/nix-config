{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.my-system.enable && config.my-system.desktop.enable) {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";
        };
        initial_session = {
          command = "Hyprland";
          user = config.my-system.user.name;
        };
      };
    };

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
  };
}
