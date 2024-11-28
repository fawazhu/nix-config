{lib, pkgs, ...}: {
  options.my-desktop = import ./options.nix {inherit lib pkgs;};

  config = {
    xdg.enable = true;
    xdg.userDirs.enable = true;
    xdg.userDirs.createDirectories = true;
  };

  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./mime.nix
    ./rofi.nix
    ./swaylock.nix
    ./swaync.nix
    ./themes.nix
    ./waybar.nix
  ];
}
