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
        rev = "d2bbee4f7e7d5bac63c054e4d8eca57954b31471";
        sha256 = "sha256-x1yqPCWuoBSx/cI94eA+AWwhiSA42cLNUOFJl7qjhmw=";
      };
      buildInputs = [bat];
      buildPhase = "bat cache --build --source . --target $out";
    };
in {
  home.packages = [pkgs.bat];
  home.file."${config.xdg.cacheHome}/bat".source = catppuccin-bat;
}
