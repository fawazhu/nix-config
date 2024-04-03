{ pkgs, ... }: {
  xdg.configFile = {
    "alacritty/themes/catppuccin".source = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "alacritty";
      rev = "071d73effddac392d5b9b8cd5b4b527a6cf289f9";
      sha256 = "sha256-HiIYxTlif5Lbl9BAvPsnXp8WAexL8YuohMDd/eCJVQ8=";
    };
    "alacritty/alacritty.toml".source = ./alacritty.toml;
  };

  home.packages = [ pkgs.alacritty ];
}
