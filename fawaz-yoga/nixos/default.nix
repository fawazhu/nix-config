{pkgs, ...}: {
  imports = [
    ../../modules/nixos/graphical
    ../../modules/nixos/system
    ../../modules/nixos/theming
    ./hardware.nix
    ./games.nix
    ./secrets.nix
  ];

  theming = {
    flavour = "macchiato";
    accent = "peach";
    scaling = 2;
  };

  users.users."fawaz" = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };
  nix.settings.trusted-users = [ "fawaz" ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamescope.enable = true;
  programs.gamescope.capSysNice = true;

  environment.localBinInPath = true;
  programs.zsh.enable = true;
  networking.hostName = "fawaz-yoga";
  system.stateVersion = "24.11";
}
