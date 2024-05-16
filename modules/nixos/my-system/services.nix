{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my-system.enable {
    services.flatpak.enable = config.my-system.flatpak.enable;
    services.printing.enable = config.my-system.bootstrap;

    environment.systemPackages = with pkgs;
      [
        systemd
      ]
      ++ (
        if config.my-system.podman.enable
        then [podman podman-compose]
        else []
      );
  };
}
