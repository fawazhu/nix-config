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
  system.stateVersion = "25.11";

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamescope.package =
    pkgs.gamescope.overrideAttrs
    {
      version = "master";
      src = pkgs.fetchFromGitHub {
        owner = "ValveSoftware";
        repo = "gamescope";
        fetchSubmodules = true;
        rev = "1faf7acd90f960b8e6c816bfea15f699b70527f9";
        hash = "sha256-/JMk1ZzcVDdgvTYC+HQL09CiFDmQYWcu6/uDNgYDfdM=";
      };
    };
  programs.gamescope.enable = true;
}
