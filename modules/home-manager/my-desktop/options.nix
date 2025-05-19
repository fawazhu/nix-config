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
