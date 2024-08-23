{
  lib,
  pkgs,
  ...
}:
with lib;
with types; let
  enableOptions = {name}:
    mkOption {
      type = bool;
      default = false;
      description = mkDoc "Whether to enable ${name}.";
    };
  nestedEnableOptions = {name}:
    mkOption {
      type = submodule {options = {enable = enableOptions {inherit name;};};};
      default = {};
      description = mkDoc "${name} integration.";
    };
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
in {
  enable = enableOptions {name = "my-system";};
  bootstrap = enableOptions {name = "bootstrap";};
  desktop = nestedEnableOptions {name = "desktop";};
  flatpak = nestedEnableOptions {name = "flatpak";};
  keyd = nestedEnableOptions {name = "keyd";};
  podman = nestedEnableOptions {name = "podman";};
  hostname = mkOption {
    type = str;
    default = null;
    description = mkDoc "Configure hostname.";
  };
  user = mkOption {
    type = submodule {
      options = {
        name = mkOption {
          type = str;
          default = "fawaz";
          description = mkDoc "Name of user to create.";
        };
      };
    };
  };
  fonts = mkOption {
    type = submodule {
      options = {
        sans = fontOptions {
          defaultName = "Noto Sans";
          defaultPackage = pkgs.noto-fonts;
        };
        serif = fontOptions {
          defaultName = "Noto Serif";
          defaultPackage = pkgs.noto-fonts;
        };
        mono = fontOptions {
          defaultName = "JetBrainsMono Nerd Font";
          defaultPackage = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        };
        emoji = fontOptions {
          defaultName = "Noto Color Emoji";
          defaultPackage = pkgs.noto-fonts-emoji;
        };
        additionalPackages = mkOption {
          type = listOf package;
          default = with pkgs; [
            material-design-icons
            noto-fonts-cjk-sans
            noto-fonts-cjk-serif
            dejavu_fonts
            freefont_ttf
            liberation_ttf
          ];
          description = mkDoc "Additional font packages to install.";
        };
      };
    };
    default = {};
    description = mkDoc "Configure fonts.";
  };
}
