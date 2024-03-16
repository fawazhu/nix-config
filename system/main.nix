{ ... }: {
  imports = [
    ./fonts.nix
    ./i18n.nix
    ./nix.nix
    ./packages.nix
    ./security.nix
    ./user.nix
    ./services/main.nix
  ];

  system.stateVersion = "24.05";
}

