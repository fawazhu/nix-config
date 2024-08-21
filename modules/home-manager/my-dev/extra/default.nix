{
  config,
  lib,
  pkgs,
  ...
}: let
  t = config.my-dev.tools;
in {
  config = lib.mkIf config.my-dev.enable {
    home.packages = with pkgs;
      (
        if t.awscli.enable
        then [awscli2 aws-vault]
        else []
      )
      ++ (
        if t.lazygit.enable
        then [lazygit]
        else []
      )
      ++ (
        if t.hcpvault.enable
        then [vault]
        else []
      )
      ++ [pre-commit];
    home.file.".aws/config".text = t.awscli.config;
  };
}
