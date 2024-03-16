{ pkgs, ... }: {
  # Applications without any configuration.
  home.packages = with pkgs; [
    gnome.seahorse
    gnome.nautilus
    gnome.file-roller
  ];
}
