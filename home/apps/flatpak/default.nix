{ flake-inputs, ... }: {
  imports = [
    ./overrides.nix
    ./packages.nix
    ./remotes.nix
    flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
}
