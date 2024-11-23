{...}: {
  imports = [
    ../../modules/nixos/hyprland
    ../../modules/nixos/system
    ./fawaz.nix
    ./hardware.nix
    ./keyd.nix
    ./secrets.nix
  ];

  environment.localBinInPath = true;
  networking.hostName = "fawaz-laptop";
  system.stateVersion = "24.11";
}
