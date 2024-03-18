{ config, pkgs, ... }: {
  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];
  programs.zsh.enable = true;

  environment.homeBinInPath = true;
  environment.localBinInPath = true;

  sops.secrets.password_fawaz.neededForUsers = true;
  users.users = {
    fawaz = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
      hashedPasswordFile = config.sops.secrets.password_fawaz.path;
    };
  };
}
