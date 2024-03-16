{ pkgs, ... }: {
  xdg.configFile = {
    "swaylock/config".source = ./config/config;
  };

  home.packages = [ pkgs.swaylock ];
}
