{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my-desktop.enable {
    xdg.configFile = {
      "alacritty/themes/catppuccin".source = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "alacritty";
        rev = "071d73effddac392d5b9b8cd5b4b527a6cf289f9";
        sha256 = "sha256-HiIYxTlif5Lbl9BAvPsnXp8WAexL8YuohMDd/eCJVQ8=";
      };
      "alacritty/alacritty.toml".text = ''
        import = ["~/.config/alacritty/themes/catppuccin/catppuccin-${config.my-desktop.catppuccinFlavour}.toml"]

        [font.normal]
        family = "${config.my-desktop.fonts.mono.name}"
        style = "Regular"

        [shell]
        args = ${config.my-desktop.apps.alacritty.args}
        program = "${config.my-desktop.apps.alacritty.shell}"
      '';
    };

    home.packages = [pkgs.alacritty];
  };
}
