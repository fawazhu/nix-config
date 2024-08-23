{
  lib,
  pkgs,
  ...
}:
with lib;
with types; let
  fontOptions = {
    defaultName,
    defaultPackage,
  }:
    mkOption {
      type = submodule {
        options = {
          name = mkOption {
            type = str;
            default = defaultName;
            description = mkDoc "Name of font to use.";
          };
          package = mkOption {
            type = package;
            default = defaultPackage;
            description = mkDoc "Package supplying font.";
          };
        };
      };
      default = {};
      description = mkDoc "Configure font.";
    };
in rec {
  enable = mkOption {
    type = bool;
    default = false;
    description = mkDoc "Whether to enable my-desktop.";
  };
  catppuccinFlavour = mkOption {
    type = str;
    default = "latte"; # fallback
    description = mkDoc "Catppuccin flavour to use.";
  };
  scaleFactor = mkOption {
    type = str;
    default = "1.25";
    description = mkDoc "Scale factor to use.";
  };
  iconTheme = mkOption {
    type = submodule {
      options = {
        name = mkOption {
          type = str;
          default =
            if catppuccinFlavour == "latte"
            then "Tela-circle"
            else "Tela-circle-dark";
          description = mkDoc "Icon theme to use.";
        };
        package = mkOption {
          type = package;
          default = pkgs.tela-circle-icon-theme;
          description = mkDoc "Icon theme package to use.";
        };
      };
    };
    default = {};
    description = mkDoc "Configure icon theme.";
  };
  cursorSize = mkOption {
    type = int;
    default = 32;
    description = mkDoc "Cursor size to use.";
  };
  fonts = mkOption {
    type = submodule {
      options = {
        sans = fontOptions {
          defaultName = "Noto Sans";
          defaultPackage = pkgs.noto-fonts;
        };
        mono = fontOptions {
          defaultName = "JetBrainsMono Nerd Font";
          defaultPackage = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        };
      };
    };
    default = {};
    description = mkDoc "Configure font.";
  };
}
