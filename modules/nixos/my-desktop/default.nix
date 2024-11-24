{lib, ...}: {
  imports = [
    ./fonts.nix
    ./extra.nix
    ./greetd.nix
  ];

  options.my-desktop.catppuccinFlavour = lib.mkOption {
    type = lib.types.str;
    default = "latte"; # fallback
    description = lib.mkDoc "Catppuccin flavour to use.";
  };
}
