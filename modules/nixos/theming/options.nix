{ lib, ... }: {
  flavour = lib.mkOption {
    type = lib.types.str;
    default = "latte";
    description = lib.mkDoc "Catppuccin flavour to use.";
  };
  accent = lib.mkOption {
    type = lib.types.str;
    default = "sky";
    description = lib.mkDoc "The accent colour to use.";
  };
  scaling = lib.mkOption {
    type = lib.types.number;
    default = 1;
    description = lib.mkDoc "The scaling factor for HiDPI.";
  };
}
