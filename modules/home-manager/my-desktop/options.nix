{
  lib,
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
in {
  catppuccinFlavour = mkOption {
    type = str;
    default = "latte"; # fallback
    description = mkDoc "Catppuccin flavour to use.";
  };
  scaleFactor = mkOption {
    type = str;
    default = "1";
    description = mkDoc "Scale factor to use.";
  };
  cursorSize = mkOption {
    type = int;
    default = 32;
    description = mkDoc "Cursor size to use.";
  };
  mimeDefaults = mkOption {
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
    default = {};
    description = mkDoc "Configure default apps.";
  };
}
