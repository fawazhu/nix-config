{ ... }: {
  imports = [
    ./fonts.nix
    ./i18n.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./security.nix
    ./services
    ./sops
    ./users
  ];

  system.stateVersion = "24.05";
}

