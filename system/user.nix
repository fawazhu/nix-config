{ pkgs, ... }: {
  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];
  programs.zsh.enable = true;

  environment.homeBinInPath = true;
  environment.localBinInPath = true;

  users.users = {
    fawaz = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };
  };
}
