{lib, ...}:
with lib;
with types; {
  ai = mkOption {
    type = bool;
    default = false;
    description = mkDoc "Whether to enable ai features.";
  };
  catppuccinFlavour = mkOption {
    type = str;
    default = "mocha";
    description = mkDoc "Catppuccin flavour to use.";
  };
  extraScript = mkOption {
    type = str;
    default = "";
    description = mkDoc "Extra script to run when starting a shell.";
  };
  fonts = mkOption {
    type = submodule {
      options = {
        mono = mkOption {
          type = str;
          default = "JetBrainsMono Nerd Font";
          description = mkdoc "Configure mono font.";
        };
      };
    };
    default = {};
    description = mkdoc "Configure fonts.";
  };
}
