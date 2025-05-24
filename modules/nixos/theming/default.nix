{lib, ...}: {
  options.theming = import ./options.nix {inherit lib;};
  imports = [./all.nix];
}
