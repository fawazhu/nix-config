{pkgs, ...}: let
  flatpak = [
    {
      name = "com.brave.Browser";
      # Mime type is disabled as not the default browser.
      # mime = "browser";
    }
    {
      name = "com.calibre_ebook.calibre";
      mime = "ebook";
    }
    {
      name = "io.bassi.Amberol";
      mime = "music";
    }
    {
      name = "org.blender.Blender";
      mime = "3d-modelling";
    }
    {
      name = "org.gimp.GIMP";
      mime = "bitmap-editor";
    }
    {
      name = "org.gnome.Calculator";
      mime = "calculator";
    }
    {
      name = "org.gnome.Calendar";
      mime = "calendar";
    }
    {
      name = "org.gnome.Connections";
      mime = "rdp";
    }
    {
      name = "org.gnome.Loupe";
      mime = "image";
    }
    {
      name = "org.gnome.font-viewer";
      mime = "font";
    }
    {
      name = "org.inkscape.Inkscape";
      mime = "vector-editor";
    }
    {
      name = "org.libreoffice.LibreOffice";
      mime = "office";
    }
    {
      name = "org.mozilla.firefox";
      mime = "browser";
    }
    {
      name = "org.kde.haruna";
      mime = "video";
    }
    {
      name = "org.kde.krita";
      mime = "creative-editor";
    }
    {
      name = "org.kde.okular";
      mime = "pdf";
    }
    {
      name = "org.kde.kdenlive";
      mime = "video-editor";
    }
    {
      name = "org.kde.kdenlive";
      mime = "text-editor";
    }
  ];
  nix = [
    {
      package = pkgs.file-roller;
      mime = "archive";
      desktop = "org.gnome.FileRoller.desktop";
    }
    {
      package = pkgs.nautilus;
      mime = "file-manager";
      desktop = "org.gnome.Files.desktop";
    }
    {
      package = pkgs.seahorse;
      mime = "secrets";
      desktop = "org.gnome.seahorse.Application.desktop";
    }
  ];
  packages = builtins.map (c: c.package) nix;
  flatpakPackages = builtins.map (c: "${c.name}//stable") flatpak;
  mime =
    (
      builtins.listToAttrs (
        builtins.map (c: {
          name = c.mime;
          value = "${c.name}.desktop";
        })
        (builtins.filter (c: builtins.hasAttr "mime" c) flatpak)
      )
    )
    // (
      builtins.listToAttrs (
        builtins.map (c: {
          name = c.mime;
          value = c.desktop;
        })
        (builtins.filter (c: builtins.hasAttr "mime" c) nix)
      )
    );
in {
  home.packages = packages;
  services.flatpak = {
    packages = flatpakPackages;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/calendar+json" = [mime.calendar];
    "application/calendar+xml" = [mime.calendar];
    "application/epub+zip" = [mime.ebook];
    "application/gzip" = [mime.archive];
    "application/http" = [mime.browser];
    "application/json" = [mime.browser];
    "application/msword" = [mime.office];
    "application/pdf" = [mime.pdf];
    "application/vnd.oasis.opendocument.presentation" = [mime.office];
    "application/vnd.oasis.opendocument.presentation-template" = [mime.office];
    "application/vnd.oasis.opendocument.spreadsheet" = [mime.office];
    "application/vnd.oasis.opendocument.spreadsheet-template" = [mime.office];
    "application/vnd.oasis.opendocument.text" = [mime.office];
    "application/vnd.oasis.opendocument.text-master" = [mime.office];
    "application/vnd.oasis.opendocument.text-template" = [mime.office];
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [mime.office];
    "application/vnd.openxmlformats-officedocument.presentationml.slideshow" = [mime.office];
    "application/vnd.openxmlformats-officedocument.presentationml.template" = [mime.office];
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [mime.office];
    "application/vnd.openxmlformats-officedocument.spreadsheetml.template" = [mime.office];
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [mime.office];
    "application/vnd.openxmlformats-officedocument.wordprocessingml.template" = [mime.office];
    "application/vnd.ms-cab-compressed" = [mime.archive];
    "application/vnd.ms-excel" = [mime.office];
    "application/vnd.ms-excel.addin.macroEnabled.12" = [mime.office];
    "application/vnd.ms-excel.sheet.macroEnabled.12" = [mime.office];
    "application/vnd.ms-excel.sheet.binary.macroEnabled.12" = [mime.office];
    "application/vnd.ms-excel.template.macroEnabled.12" = [mime.office];
    "application/vnd.ms-powerpoint.addin.macroEnabled.12" = [mime.office];
    "application/vnd.ms-powerpoint.presentation.macroEnabled.12" = [mime.office];
    "application/vnd.ms-powerpoint.slideshow.macroEnabled.12" = [mime.office];
    "application/vnd.ms-powerpoint.template.macroEnabled.12" = [mime.office];
    "application/vnd.ms-word.document.macroEnabled.12" = [mime.office];
    "application/vnd.ms-word.template.macroEnabled.12" = [mime.office];
    "application/vnd.rar" = [mime.archive];
    "application/x-7z-compressed" = [mime.archive];
    "application/x-archive" = [mime.archive];
    "application/x-bcpio" = [mime.archive];
    "application/x-bzip" = [mime.archive];
    "application/x-bzip-compressed-tar" = [mime.archive];
    "application/x-compress" = [mime.archive];
    "application/x-cpio-compressed" = [mime.archive];
    "application/x-cd-image" = [mime.archive];
    "application/x-cpio" = [mime.archive];
    "application/x-compressed-tar" = [mime.archive];
    "application/x-krita" = [mime.creative-editor];
    "application/x-iso9660-appimage" = [mime.archive];
    "application/x-lha" = [mime.archive];
    "application/x-lrzip-compressed-tar" = [mime.archive];
    "application/x-lz4-compressed-tar" = [mime.archive];
    "application/x-lzip-compressed-tar" = [mime.archive];
    "application/x-lzma" = [mime.archive];
    "application/x-lzma-compressed-tar" = [mime.archive];
    "application/x-matroska" = [mime.video];
    "application/x-rar" = [mime.archive];
    "application/x-source-rpm" = [mime.archive];
    "application/x-sv4cpio" = [mime.archive];
    "application/x-sv4crc" = [mime.archive];
    "application/x-tar" = [mime.archive];
    "application/x-tarz" = [mime.archive];
    "application/x-tzo" = [mime.archive];
    "application/x-xar" = [mime.archive];
    "application/x-xz" = [mime.archive];
    "application/x-xz-compressed-tar" = [mime.archive];
    "application/x-yaml" = [mime.text-editor];
    "application/x-zstd-compressed-tar" = [mime.archive];
    "application/xml" = [mime.browser];
    "application/zip" = [mime.archive];
    "application/zstd" = [mime.archive];
    "audio/aac" = [mime.music];
    "audio/flac" = [mime.music];
    "audio/mp3" = [mime.music];
    "audio/mp4" = [mime.music];
    "audio/mpeg" = [mime.music];
    "audio/mpegurl" = [mime.music];
    "audio/ogg" = [mime.music];
    "audio/vnd.rn-realaudio" = [mime.music];
    "audio/vorbis" = [mime.music];
    "audio/x-flac" = [mime.music];
    "audio/x-mp3" = [mime.music];
    "audio/x-mpegurl" = [mime.music];
    "audio/x-ms-wma" = [mime.music];
    "audio/x-musepack" = [mime.music];
    "audio/x-oggflac" = [mime.music];
    "audio/x-pn-realaudio" = [mime.music];
    "audio/x-scpls" = [mime.music];
    "audio/x-speex" = [mime.music];
    "audio/x-vorbis" = [mime.music];
    "audio/x-vorbis+ogg" = [mime.music];
    "audio/x-wav" = [mime.music];
    "font/collection" = [mime.font];
    "font/otf" = [mime.font];
    "font/ttf" = [mime.font];
    "image/apng" = [mime.image];
    "image/avif" = [mime.image];
    "image/bmp" = [mime.image];
    "image/gif" = [mime.image];
    "image/heif" = [mime.image];
    "image/jpeg" = [mime.image];
    "image/jxl" = [mime.image];
    "image/png" = [mime.image];
    "image/svg+xml" = [mime.image];
    "image/tiff" = [mime.image];
    "image/webp" = [mime.image];
    "image/x-eps" = [mime.image];
    "image/x-icns" = [mime.image];
    "image/x-ico" = [mime.image];
    "image/x-portable-bitmap" = [mime.image];
    "image/x-portable-graymap" = [mime.image];
    "image/x-portable-pixmap" = [mime.image];
    "image/x-psd" = [mime.image];
    "image/x-tga" = [mime.image];
    "image/x-webp" = [mime.image];
    "image/x-xbitmap" = [mime.image];
    "image/x-xpixmap" = [mime.image];
    "image/x-xcf" = [mime.bitmap-editor];
    "inode/directory" = [mime.file-manager];
    "text/calendar" = [mime.calendar];
    "text/css" = [mime.text-editor];
    "text/csv" = [mime.text-editor];
    "text/html" = [mime.browser];
    "text/javascript" = [mime.text-editor];
    "text/markdown" = [mime.text-editor];
    "text/plain" = [mime.text-editor];
    "text/rtf" = [mime.office];
    "text/tab-separated-values" = [mime.text-editor];
    "text/xml" = [mime.text-editor];
    "text/yaml" = [mime.text-editor];
    "video/AV1" = [mime.video];
    "video/3gp" = [mime.video];
    "video/3gpp" = [mime.video];
    "video/3gpp2" = [mime.video];
    "video/avi" = [mime.video];
    "video/divx" = [mime.video];
    "video/dv" = [mime.video];
    "video/fli" = [mime.video];
    "video/flv" = [mime.video];
    "video/mp2t" = [mime.video];
    "video/mp4" = [mime.video];
    "video/mp4v-es" = [mime.video];
    "video/mpeg" = [mime.video];
    "video/msvideo" = [mime.video];
    "video/ogg" = [mime.video];
    "video/quicktime" = [mime.video];
    "video/raw" = [mime.video];
    "video/vnd.divx" = [mime.video];
    "video/vnd.mpegurl" = [mime.video];
    "video/vnd.rn-realvideo" = [mime.video];
    "video/webm" = [mime.video];
    "video/x-avi" = [mime.video];
    "video/x-flv" = [mime.video];
    "video/x-m4v" = [mime.video];
    "video/x-matroska" = [mime.video];
    "video/x-mpeg2" = [mime.video];
    "video/x-ms-asf" = [mime.video];
    "video/x-msvideo" = [mime.video];
    "video/x-ms-wmv" = [mime.video];
    "video/x-ms-wmx" = [mime.video];
    "video/x-ogm" = [mime.video];
    "video/x-ogm+ogg" = [mime.video];
    "video/x-theora" = [mime.video];
    "video/x-theora+ogg" = [mime.video];
    "video/x-totem-stream" = [mime.video];
    "x-content/image-dcf" = [mime.video];
    "x-content/image-picturecd" = [mime.video];
    "x-content/video-dvd" = [mime.video];
    "x-content/video-svcd" = [mime.video];
    "x-content/video-vcd" = [mime.video];
    "x-scheme-handler/http" = [mime.browser];
    "x-scheme-handler/https" = [mime.browser];
    "x-scheme-handler/trash" = [mime.file-manager];
  };
}
