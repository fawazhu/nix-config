{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.my-apps.enable && config.my-apps.alacritty.enable) {
    xdg.configFile = {
      "alacritty/themes/catppuccin".source = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "alacritty";
        rev = "f6cb5a5c2b404cdaceaff193b9c52317f62c62f7";
        sha256 = "sha256-H8bouVCS46h0DgQ+oYY8JitahQDj0V9p2cOoD4cQX+Q=";
      };
      "alacritty/alacritty.toml".text = ''
        [general]
        import = ["~/.config/alacritty/themes/catppuccin/catppuccin-${config.my-apps.catppuccinFlavour}.toml"]

        [font.normal]
        family = "${config.my-apps.fonts.mono}"
        style = "Regular"

        [terminal.shell]
        args = ${config.my-apps.alacritty.args}
        program = "${config.my-apps.alacritty.shell}"
      '';
    };

    home.packages = [pkgs.alacritty];
  };
}
