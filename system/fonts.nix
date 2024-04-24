{pkgs, ...}: {
  # Fonts work best at the system level.
  fonts = {
    packages = with pkgs; [
      material-design-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
      dejavu_fonts
      freefont_ttf
      liberation_ttf
    ];

    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif" "Noto Color Emoji"]; # Noto Color Emoji to default to for emojis.
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
      hinting.style = "slight";
      subpixel.rgba = "rgb";
    };

    fontDir.enable = true;
  };
}
