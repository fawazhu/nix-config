{pkgs, ...}: {
  boot.plymouth.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.sessionPackages = [pkgs.hyprland];
  environment.systemPackages = [pkgs.gnome-session];
}
