{ ... }: {
  imports = [
    ./user.nix
    ./apps/main.nix
    ./desktop/main.nix
    ./tools/main.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
