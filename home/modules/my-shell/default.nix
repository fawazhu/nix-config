{lib, ...}: {
  options.my-shell = import ./options.nix {inherit lib;};

  config = {};

  imports = [
    ./bat.nix
    ./git.nix
    ./packages.nix
    ./tmux
    ./zsh
  ];
}
