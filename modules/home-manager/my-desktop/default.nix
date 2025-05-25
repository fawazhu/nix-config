{
  lib,
  pkgs,
  ...
}: {
  options.my-desktop = import ./options.nix {inherit lib pkgs;};

  config = {
    xdg.enable = true;
    xdg.userDirs.enable = true;
    xdg.userDirs.createDirectories = true;
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        hyprland = {
          default = ["gtk" "hyprland"];
          "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
          "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
        };
        gnome = {
          default = ["gnome"];
          "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
        };
        common = {
          default = ["gtk"];
        };
      };
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
        #pkgs.xdg-desktop-portal-gnome
      ];
    };
  };

  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./mime.nix
    ./plasma.nix
    ./waybar.nix
  ];
}
