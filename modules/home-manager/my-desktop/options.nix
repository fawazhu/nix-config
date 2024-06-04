{
  lib,
  pkgs,
  ...
}:
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
  enable = enableOptions {name = "my-desktop";};
  catppuccinFlavour = mkOption {
    type = str;
    default = "latte"; # fallback
    description = mkDoc "Catppuccin flavour to use.";
  };
  apps = mkOption {
    type = submodule {
      options = {
        alacritty = mkOption {
          type = submodule {
            options = {
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
          default = with pkgs; [
            gnome.seahorse
            gnome.nautilus
            gnome.file-roller
            gparted
          ];
          description = mkDoc "Configure default app nix packages.";
        };
        flatpak = mkOption {
          type = submodule {
            options = {
              packages = mkOption {
                type = listOf str;
                default = [
                  "ca.desrt.dconf-editor//stable"
                  "com.github.tchx84.Flatseal//stable"
                  "org.gnome.Calculator//stable"
                  "org.gnome.Loupe//stable"
                  "org.gnome.baobab//stable"
                  "org.gnome.font-viewer//stable"
                  "org.inkscape.Inkscape//stable"
                  "org.mozilla.firefox//stable"
                  "org.onlyoffice.desktopeditors//stable"
                  "org.gnome.Calendar//stable"
                  "org.gnome.Evince//stable"
                  "org.gnome.Totem//stable"
                  "io.bassi.Amberol//stable"
                  "org.kde.krita//stable"
                  "org.kde.kdenlive//stable"
                  "org.videolan.VLC//stable"
                  "com.brave.Browser//stable"
                  "org.libreoffice.LibreOffice//stable"
                  "org.blender.Blender//stable"
                  "com.calibre_ebook.calibre//stable"
                ];
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
        mimeDefault = mkOption {
          type = submodule {
            options = {
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
          default = {
            archive = "org.gnome.FileRoller.desktop";
            browser = "org.mozilla.firefox.desktop";
            calendar = "com.calibre_ebook.calibre.desktop";
            document = "org.libreoffice.LibreOffice.desktop";
            ebook = "com.calibre_ebook.calibre.desktop";
            editor = "nvim.desktop";
            font = "org.gnome.font-viewer.desktop";
            image = "org.gnome.Loupe.desktop";
            music = "io.bassi.Amberol.desktop";
            pdf = "org.gnome.Evince.desktop";
            video = "org.gnome.Totem.desktop";
          };
          description = mkDoc "Configure default apps.";
        };
      };
    };
    default = {};
    description = mkDoc "Configure apps.";
  };
  services = mkOption {
    type = submodule {
      options = {
        kdeconnect = nestedEnableOptions {name = "kdeconnect";};
      };
    };
    default = {
      kdeconnect = {enable = true;};
    };
    description = mkDoc "Configure services.";
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
