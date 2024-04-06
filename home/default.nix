{ ... }: {
  imports = [
    ./shell.nix
    ./ssh.nix
    ./user.nix
    ./apps
    ./desktop
    ./dev
    ./sops
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
