{ pkgs, ... }: {
  xdg.configFile = {
    "swaync/style.css".source = ./config/style.css;
  };
  home.packages = [ pkgs.swaynotificationcenter ];
}
