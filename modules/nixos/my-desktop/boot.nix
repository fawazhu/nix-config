{pkgs, ...}: {
  boot.plymouth.enable = true;
  services.displayManager.sessionPackages = [pkgs.hyprland pkgs.gnome-session];
}
