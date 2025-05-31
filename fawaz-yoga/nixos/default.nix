{pkgs, ...}: {
  imports = [
    ../../modules/nixos/graphical
    ../../modules/nixos/system
    ./hardware.nix
    ./secrets.nix
  ];

  users.users."fawaz" = {
    description = "Fawaz";
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };
  nix.settings.trusted-users = ["fawaz"];

  environment.localBinInPath = true;
  programs.zsh.enable = true;
  networking.hostName = "fawaz-yoga";
  system.stateVersion = "24.11";

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamescope.enable = true;
  programs.gamescope.capSysNice = true;
}
