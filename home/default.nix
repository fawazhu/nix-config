{ ... }: {
  imports = [
    ./user.nix
    ./apps
    ./desktop
    ./sops
    ./tools
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
