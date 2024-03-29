{ ... }: {
  imports = [
    ./fonts.nix
    ./i18n.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./security.nix
    ./user.nix
    ./services/main.nix
  ];
  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.keyFile = "/etc/sops/age/keys.txt";

  system.stateVersion = "24.05";
}

