{
  config,
  pkgs,
  ...
}: let
  catppuccin-btop = with pkgs;
    stdenv.mkDerivation {
      pname = "catppuccin-btop";
      version = "1.0.0";
      src = fetchFromGitHub {
        owner = "catppuccin";
        repo = "btop";
        rev = "1.0.0";
        sha256 = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
      };
      installPhase = ''
        mkdir -p $out
        cp -r themes $out/
      '';
    };
in {
  programs.btop.enable = true;
  programs.btop.extraConfig = ''
    color_theme = "${catppuccin-btop}/themes/catppuccin_${config.my-dev.catppuccinFlavour}.theme"
  '';
}
