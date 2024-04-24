{pkgs, ...}: {
  home.sessionVariables."GRIM_DEFAULT_DIR" = "/home/fawaz/Pictures/Screenshots";
  home.packages = [pkgs.grim];
}
