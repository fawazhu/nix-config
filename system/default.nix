{ ... }: {
  imports = [
    ./fonts.nix
    ./i18n.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./security.nix
    ./services
    ./users
  ];

  system.stateVersion = "24.05";
}

