{
  config,
  lib,
  ...
}: let
  mime = config.my-apps.mimeDefaults;
in {
  config = lib.mkIf (config.my-apps.enable && mime.enable) {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/calendar+json" = [mime.calendar];
        "application/calendar+xml" = [mime.calendar];
        "application/epub+zip" = [mime.ebook];
        "application/gzip" = [mime.archive];
        "application/http" = [mime.browser];
        "application/json" = [mime.browser];
        "application/msword" = [mime.document];
        "application/pdf" = [mime.pdf];
        "application/xml" = [mime.browser];
        "application/vnd.oasis.opendocument.presentation" = [mime.document];
        "application/vnd.oasis.opendocument.presentation-template" = [mime.document];
        "application/vnd.oasis.opendocument.spreadsheet" = [mime.document];
        "application/vnd.oasis.opendocument.spreadsheet-template" = [mime.document];
        "application/vnd.oasis.opendocument.text" = [mime.document];
        "application/vnd.oasis.opendocument.text-master" = [mime.document];
        "application/vnd.oasis.opendocument.text-template" = [mime.document];
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [mime.document];
        "application/vnd.openxmlformats-officedocument.presentationml.slideshow" = [mime.document];
        "application/vnd.openxmlformats-officedocument.presentationml.template" = [mime.document];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [mime.document];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.template" = [mime.document];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [mime.document];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.template" = [mime.document];
        "application/vnd.ms-excel" = [mime.document];
        "application/vnd.ms-excel.addin.macroEnabled.12" = [mime.document];
        "application/vnd.ms-excel.sheet.macroEnabled.12" = [mime.document];
        "application/vnd.ms-excel.sheet.binary.macroEnabled.12" = [mime.document];
        "application/vnd.ms-excel.template.macroEnabled.12" = [mime.document];
        "application/vnd.ms-powerpoint.addin.macroEnabled.12" = [mime.document];
        "application/vnd.ms-powerpoint.presentation.macroEnabled.12" = [mime.document];
        "application/vnd.ms-powerpoint.slideshow.macroEnabled.12" = [mime.document];
        "application/vnd.ms-powerpoint.template.macroEnabled.12" = [mime.document];
        "application/vnd.ms-word.document.macroEnabled.12" = [mime.document];
        "application/vnd.ms-word.template.macroEnabled.12" = [mime.document];
        "audio/aac" = [mime.music];
        "audio/flac" = [mime.music];
        "audio/mp3" = [mime.music];
        "audio/ogg" = [mime.music];
        "font/collection" = [mime.font];
        "font/otf" = [mime.font];
        "font/ttf" = [mime.font];
        "image/apng" = [mime.image];
        "image/avif" = [mime.image];
        "image/bmp" = [mime.image];
        "image/gif" = [mime.image];
        "image/jpeg" = [mime.image];
        "image/png" = [mime.image];
        "image/svg+xml" = [mime.image];
        "image/tiff" = [mime.image];
        "image/webp" = [mime.image];
        "text/calendar" = [mime.calendar];
        "text/css" = [mime.editor];
        "text/csv" = [mime.editor];
        "text/html" = [mime.browser];
        "text/javascript" = [mime.editor];
        "text/markdown" = [mime.editor];
        "text/plain" = [mime.editor];
        "text/rtf" = [mime.document];
        "text/tab-separated-values" = [mime.editor];
        "text/xml" = [mime.editor];
        "text/yaml" = [mime.editor];
        "video/AV1" = [mime.video];
        "video/mp4" = [mime.video];
        "video/mpeg" = [mime.video];
        "video/ogg" = [mime.video];
        "video/raw" = [mime.video];
        "video/webm" = [mime.video];
        "x-scheme-handler/http" = [mime.browser];
        "x-scheme-handler/https" = [mime.browser];
      };
    };
  };
}
