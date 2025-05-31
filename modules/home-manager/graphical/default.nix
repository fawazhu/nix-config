{pkgs, ...}: {
  imports = [./apps.nix ./plasma.nix ./theming.nix];

  dconf.enable = true;
  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.preferred = {
      default = ["kde"];
      "org.freedesktop.impl.portal.Settings" = ["kde" "gtk"];
      "org.freedesktop.impl.portal.Secret" = ["kwallet"];
    };
    extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde pkgs.xdg-desktop-portal-gtk];
  };
}
