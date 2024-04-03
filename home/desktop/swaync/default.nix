{ pkgs, ... }: {
  xdg.configFile."swaync/style.css".source = ./style.css;
  home.packages = [ pkgs.swaynotificationcenter ];
}
