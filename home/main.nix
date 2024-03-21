{ config, ... }: {
  imports = [
    ./user.nix
    ./apps/main.nix
    ./desktop/main.nix
    ./tools/main.nix
  ];
  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.keyFile = "/home/fawaz/.config/sops/age/keys.txt";
  home.activation.setupEtc = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    /run/current-system/sw/bin/systemctl start --user sops-nix
  '';

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
