{config, lib, pkgs, ...}: {
  options.my-desktop = import ./options.nix {inherit lib pkgs;};

  config = lib.mkIf config.my-desktop.enable {
    services.kdeconnect.enable = config.my-desktop.services.kdeconnect.enable;
    xdg = {
      enable = true;
      userDirs.enable = true;
      userDirs.createDirectories = true;
    };
  };

  imports = [
    ./apps
    ./desktop
  ];
}
