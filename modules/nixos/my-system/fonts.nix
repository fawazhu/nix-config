{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.my-system.enable {
    # Fonts work best at the system level.
    fonts = {
      packages =
        [
          config.my-system.fonts.sans.package
          config.my-system.fonts.serif.package
          config.my-system.fonts.mono.package
          config.my-system.fonts.emoji.package
        ]
        ++ config.my-system.fonts.additionalPackages;

      enableDefaultPackages = false;

      fontconfig = {
        defaultFonts = {
          serif = [config.my-system.fonts.serif.name config.my-system.fonts.emoji.name]; # Noto Color Emoji to default to for emojis.
          sansSerif = [config.my-system.fonts.sans.name config.my-system.fonts.emoji.name];
          monospace = [config.my-system.fonts.mono.name config.my-system.fonts.emoji.name];
          emoji = [config.my-system.fonts.emoji.name];
        };
        hinting.style = "slight";
        subpixel.rgba = "rgb";
      };

      fontDir.enable = true;
    };
  };
}
