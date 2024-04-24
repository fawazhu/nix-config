{pkgs, ...}: {
  home.file = {
    ".local/share/rofi/themes".source = "${pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "rofi";
      rev = "5350da41a11814f950c3354f090b90d4674a95ce";
      sha256 = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
    }}/basic/.local/share/rofi/themes";
    ".local/bin/rofi-power-menu".source = "${pkgs.fetchFromGitHub {
      owner = "jluttine";
      repo = "rofi-power-menu";
      rev = "3.1.0";
      sha256 = "sha256-VPCfmCTr6ADNT7MW4jiqLI/lvTjlAu1QrCAugiD0toU=";
    }}/rofi-power-menu";
  };

  xdg.configFile."rofi/config.rasi".source = ./config.rasi;

  home.packages = [pkgs.rofi-wayland-unwrapped];
}
