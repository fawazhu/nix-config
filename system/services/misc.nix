{ pkgs, ... }: {
  # Services that do not require additional configuration
  services.flatpak.enable = true;
  services.printing.enable = true; # TODO: automate cups configuration.
  services.blueman.enable = true; # TODO: automate bluetooth.

  environment.systemPackages = [
    pkgs.systemd
    pkgs.podman
  ];
}
