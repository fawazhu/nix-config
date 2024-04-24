{
  config,
  pkgs,
  ...
}: let
  t = config.my-dev.tools;
in {
  home.packages = with pkgs;
    (
      if t.awscli.enable
      then [awscli2]
      else []
    )
    ++ (
      if t.lazygit.enable
      then [lazygit]
      else []
    );
}
