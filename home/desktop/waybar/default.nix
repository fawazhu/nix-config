{pkgs, ...}: let
  # Hot-fix waybar until it reaches nixpkgs.
  wireplumber_0_4 = pkgs.wireplumber.overrideAttrs (attrs: rec {
    version = "0.4.17";
    src = pkgs.fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "pipewire";
      repo = "wireplumber";
      rev = version;
      hash = "sha256-vhpQT67+849WV1SFthQdUeFnYe/okudTQJoL3y+wXwI=";
    };
  });
  waybar = pkgs.waybar.override {wireplumber = wireplumber_0_4;};
in {
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

  home.packages = [waybar];
}
