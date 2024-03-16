{ ... }: {
  imports = [
    ./kdeconnect.nix
    ./misc.nix
    ./alacritty/main.nix
    ./flatpak/main.nix
    ./neovim/main.nix
  ];
}
