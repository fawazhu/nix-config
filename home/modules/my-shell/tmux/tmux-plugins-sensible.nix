{ pkgs, ... }: with pkgs; stdenv.mkDerivation (finalAttrs: {
  pname = "tmux-plugins-sensible";
  version = "v3.0.0";

  src = fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tmux-sensible";
    rev  = finalAttrs.version;
    sha256 = "sha256-ney/Y1YtCsWLgthOmoYGZTpPfJz+DravRB31YZgnDuU=";
  };

  installPhase = ''
    mkdir -p $out/share/tmux-plugins
    cp -r . $out/share/tmux-plugins/tmux-sensible
  '';
})
