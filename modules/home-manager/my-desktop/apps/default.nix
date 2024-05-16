{
  config,
  lib,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./btop.nix
    ./flatpak.nix
    ./alacritty.nix
    ./mime.nix
  ];

  config = lib.mkIf config.my-desktop.enable {
    home.packages = config.my-desktop.apps.packages;
  };
}
