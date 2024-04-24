{pkgs, ...}: {
  xdg.configFile."swaylock/config".source = ./config;
  home.packages = [pkgs.swaylock];
}
