{
  config,
  pkgs,
  ...
}: let
  catppuccin-alacritty = with pkgs;
    stdenv.mkDerivation {
      pname = "catppuccin-alacritty";
      version = "20241128";
      src = fetchFromGitHub {
        owner = "catppuccin";
        repo = "alacritty";
        rev = "f6cb5a5c2b404cdaceaff193b9c52317f62c62f7";
        sha256 = "sha256-H8bouVCS46h0DgQ+oYY8JitahQDj0V9p2cOoD4cQX+Q=";
      };
      installPhase = ''
        mkdir -p $out
        cp ./*.toml $out/
      '';
    };
in {
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    general.import = ["${catppuccin-alacritty}/catppuccin-${config.my-dev.catppuccinFlavour}.toml"];
    font.normal = {
      family = config.my-dev.fonts.mono;
      style = "Regular";
    };
    terminal.shell = {
      args = ["-ci" "tmux"];
      program = "${pkgs.zsh}/bin/zsh";
    };
  };
}
