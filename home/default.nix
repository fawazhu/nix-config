{ ... }: {
  imports = [
    ./user.nix
    ./apps
    ./desktop
    ./tools
  ];
  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.keyFile = "/home/fawaz/.config/sops/age/keys.txt";
  
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
