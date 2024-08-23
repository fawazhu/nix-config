{
  config,
  lib,
  ...
}: {
  options.my-apps = import ./options.nix {inherit lib;};

  config = lib.mkIf config.my-apps.enable {
    home.packages = config.my-apps.packages;
  };

  imports = [
    ./alacritty.nix
    ./btop.nix
    ./flatpak.nix
    ./mime.nix
    ./services.nix
  ];

}
