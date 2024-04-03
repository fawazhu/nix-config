{ pkgs, ... }: {
  imports = [
    ./btop.nix
    ./mime.nix
    ./alacritty
    ./flatpak
    ./neovim
  ];

  home.packages = with pkgs; [
    gnome.seahorse
    gnome.nautilus
    gnome.file-roller
  ];

  services.kdeconnect.enable = true;
}
