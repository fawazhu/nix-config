{pkgs, ...}: {
  xdg.configFile = {
    "waybar/themes".source = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "waybar";
      rev = "v1.0";
      sha256 = "sha256-vfwfBE3iqIN1cGoItSssR7h0z6tuJAhNarkziGFlNBw=";
    };
    "waybar/config".source = ./config;
    "waybar/style.css".source = ./style.css;
  };

  home.packages = [pkgs.waybar];
}
