{...}: {
  imports = [
    ../../modules/nixos/my-desktop
    ../../modules/nixos/system
    ./fawaz.nix
    ./hardware.nix
    ./keyd.nix
    ./secrets.nix
  ];

  my-desktop.catppuccinFlavour = "latte";
  environment.localBinInPath = true;
  networking.hostName = "fawaz-laptop";
  system.stateVersion = "24.11";
}
