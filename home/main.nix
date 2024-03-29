{ ... }: {
  imports = [
    ./user.nix
    ./apps/main.nix
    ./desktop/main.nix
    ./tools/main.nix
  ];
  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.keyFile = "/home/fawaz/.config/sops/age/keys.txt";
  
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
