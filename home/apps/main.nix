{ ... }: {
  imports = [
    ./kdeconnect.nix
    ./mime.nix
    ./misc.nix
    ./alacritty/main.nix
    ./flatpak/main.nix
    ./neovim/main.nix
  ];
}
