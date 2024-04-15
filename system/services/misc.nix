{ pkgs, ... }: {
  # Services that do not require additional configuration
  services.flatpak.enable = true;
  services.printing.enable = true;
  services.blueman.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = [
    pkgs.systemd
    pkgs.podman
  ];
}
