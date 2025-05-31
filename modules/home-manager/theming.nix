{lib, ...}:
with lib;
with types; {
  options.theming = {
    flavour = mkOption {
      type = str;
      default = "latte";
      description = mkDoc "Catppuccin flavour to use.";
    };
    accent = mkOption {
      type = str;
      default = "sky";
      description = lib.mkDoc "The accent colour to use.";
    };
    scaling = mkOption {
      type = number;
      default = 1;
      description = mkDoc "The scaling factor for HiDPI.";
    };
  };
}
