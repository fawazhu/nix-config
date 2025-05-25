{pkgs, ...}: {
  imports = [./fonts.nix];

  boot.plymouth.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.sessionPackages = with pkgs; [hyprland gnome-session.sessions];

  services.gnome.core-os-services.enable = true;
  services.gnome.core-shell.enable = true;

  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = true;

  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  services.xserver.xkb.layout = "gb";
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    gsettings-desktop-schemas
    libsecret
  ];
}
