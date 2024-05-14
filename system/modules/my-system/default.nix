{
  config,
  lib,
  pkgs,
  ...
}: {
  options.my-system = import ./options.nix {inherit lib pkgs;};

  config = {};

  imports = [
    ./desktop.nix
    ./fonts.nix
    ./i18n.nix
    ./keyd.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./security.nix
    ./services.nix
    ./sound.nix
    ./users.nix
  ];
}
