{lib, ...}:
with lib;
with types; let
  appMimeDefaultOptions = {name}:
    mkOption {
      type = str;
      default = null;
      description = mkDoc "Configure default app for ${name}.";
    };
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
in {
  enable = enableOptions {name = "my-apps";};
  catppuccinFlavour = mkOption {
    type = str;
    default = "latte"; # fallback
    description = mkDoc "Catppuccin flavour to use.";
  };
  alacritty = mkOption {
    type = submodule {
      options = {
        enable = enableOptions {name = "alacritty";};
        args = mkOption {
          type = str;
          default = "[]";
          description = mkDoc "Additional arguments to pass to alacritty when executing the shell.";
        };
        shell = mkOption {
          type = str;
          default = "bash";
          description = mkDoc "Shell to use for alacritty.";
        };
      };
    };
    default = {};
    description = mkDoc "Configure alacritty.";
  };
  packages = mkOption {
    type = listOf package;
    default = [];
    description = mkDoc "Configure extra packages to install.";
  };
  flatpak = mkOption {
    type = submodule {
      options = {
        packages = mkOption {
          type = listOf str;
          default = [];
          description = mkDoc "Configure flatpak packages.";
        };
        remotes = mkOption {
          type = listOf (submodule {
            options = {
              name = mkOption {
                type = str;
                description = mkDoc "Flatpak remote name.";
              };
              location = mkOption {
                type = str;
                description = mkDoc "Flatpak remote location.";
              };
            };
          });
          default = [
            {
              name = "flathub";
              location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
            }
          ];
          description = mkDoc "Configure flatpak remotes.";
        };
      };
    };
    default = {};
    description = mkDoc "Configure flatpak apps.";
  };
  mimeDefaults = mkOption {
    type = submodule {
      options = {
        enable = enableOptions {name = "mimeDefaults";};
        archive = appMimeDefaultOptions {name = "archive";};
        browser = appMimeDefaultOptions {name = "browser";};
        calendar = appMimeDefaultOptions {name = "calendar";};
        document = appMimeDefaultOptions {name = "document";};
        ebook = appMimeDefaultOptions {name = "ebook";};
        editor = appMimeDefaultOptions {name = "editor";};
        font = appMimeDefaultOptions {name = "font";};
        image = appMimeDefaultOptions {name = "image";};
        music = appMimeDefaultOptions {name = "music";};
        pdf = appMimeDefaultOptions {name = "pdf";};
        video = appMimeDefaultOptions {name = "video";};
      };
    };
    default = {};
    description = mkDoc "Configure default apps.";
  };
  services = mkOption {
    type = submodule {
      options = {
        kdeconnect = nestedEnableOptions {name = "kdeconnect";};
      };
    };
    default = {};
    description = mkDoc "Configure services.";
  };
  fonts = mkOption {
    type = submodule {
      options = {
        mono = mkOption {
          type = str;
          default = "JetBrainsMono Nerd Font";
          description = mkDoc "Configure mono font.";
        };
      };
    };
    default = {};
    description = mkDoc "Configure fonts.";
  };
}
