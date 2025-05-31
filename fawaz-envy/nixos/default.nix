{pkgs, ...}: {
  imports = [
    ../../modules/nixos/my-desktop
    ../../modules/nixos/system
    ./hardware.nix
    ./keyd.nix
    ./secrets.nix
  ];

  graphical = {
    flavour = "macchiato";
    accent = "lavender";
    scaling = 1.25;
  };

  users.users."fawaz" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };
  nix.settings.trusted-users = [ "fawaz" ];

  environment.localBinInPath = true;
  programs.zsh.enable = true;
  networking.hostName = "fawaz-envy";
  system.stateVersion = "24.11";
}
