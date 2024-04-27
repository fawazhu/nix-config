{
  config,
  pkgs,
  ...
}: let
  catppuccin-bat = with pkgs;
    stdenv.mkDerivation {
      pname = "catppuccin-bat";
      version = "2024-04-27";
      src = fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "d714cc1d358ea51bfc02550dabab693f70cccea0";
        sha256 = "sha256-Q5B4NDrfCIK3UAMs94vdXnR42k4AXCqZz6sRn8bzmf4=";
      };
      buildInputs = [bat];
      buildPhase = ''
        bat cache --build --source . --target $out
      '';
    };
in {
  home.packages = [pkgs.bat];
  home.file."${config.xdg.cacheHome}/bat".source = catppuccin-bat;
}
