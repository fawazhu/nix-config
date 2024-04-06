{ lib, ... }: {
  options.my-shell = import ./options.nix { inherit lib; };

  config = {};

  imports = [
    ./git.nix
    ./packages.nix
    ./tmux
    ./zsh
  ];
}
