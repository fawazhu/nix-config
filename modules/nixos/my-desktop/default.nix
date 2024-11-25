{lib, ...}: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./extra.nix
  ];

  options.my-desktop.catppuccinFlavour = lib.mkOption {
    type = lib.types.str;
    default = "latte"; # fallback
    description = lib.mkDoc "Catppuccin flavour to use.";
  };
}
