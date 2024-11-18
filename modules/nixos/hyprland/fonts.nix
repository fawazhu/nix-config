{pkgs, ...}: let
  jetbrainsmononf = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
in {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      jetbrainsmononf
      noto-fonts-emoji
      material-design-icons
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      dejavu_fonts
      freefont_ttf
      liberation_ttf
      source-sans
      source-serif
    ];
    enableDefaultPackages = false;
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["JetBrainsMono Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
      hinting.style = "slight";
      subpixel.rgba = "rgb";
    };
    fontDir.enable = true;
  };
}
