{ config, pkgs, lib, ... }: {
  imports = [
    ./btop.nix
    ./git.nix
    ./utils.nix
    ./dev/main.nix
    ./tmux/main.nix
    ./zsh/main.nix
  ];
}
