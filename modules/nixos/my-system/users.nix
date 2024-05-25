{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.my-system.enable && config.my-system.bootstrap) {
    environment.shells = [pkgs.bashInteractive pkgs.zsh];
    programs.zsh.enable = true;

    environment.homeBinInPath = true;
    environment.localBinInPath = true;

    sops.secrets.password_fawaz.neededForUsers = true;
    users.users."${config.my-system.user.name}" = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
    };
    users.users.guest = {
      isNormalUser = true;
      shell = pkgs.bashInteractive;
    };
  };
}
