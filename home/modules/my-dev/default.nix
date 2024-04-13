{ lib, ... }: {
  options.my-dev = import ./options.nix { inherit lib; };

  config = {};

  imports = [
    ./extra
    ./languages
    ./neovim
  ];
}
