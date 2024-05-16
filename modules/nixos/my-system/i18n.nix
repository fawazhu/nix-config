{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.my-system.enable && config.my-system.bootstrap) {
    console = {
      font = "lat2-16";
      keyMap = "uk";
    };
    i18n = {
      defaultLocale = "en_GB.UTF-8";
      supportedLocales = ["en_GB.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];
    };
    time.timeZone = "Europe/London";
  };
}
