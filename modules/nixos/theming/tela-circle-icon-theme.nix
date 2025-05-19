{
  lib,
  stdenv,
  fetchFromGitHub,
  gtk3,
  hex,
  jdupes,
  gitUpdater,
  ...
}:
stdenv.mkDerivation rec {
  pname = "tela-circle-icon-theme";
  version = "2025-02-10";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = pname;
    rev = version;
    hash = "sha256-5Kqf6QNM+/JGGp2H3Vcl69Vh1iZYPq3HJxhvSH6k+eQ=";
  };

  dontPatchELF = true;
  dontRewriteSymlinks = true;

  postPatch = ''
    patchShebangs install.sh
  '';

  nativeBuildInputs = [gtk3 jdupes];

  installPhase = ''
    runHook preInstall

    bash install.sh -d $out/share/icons -c ${hex}

    jdupes --quiet --link-soft --recurse $out/share

    runHook postInstall
  '';

  passthru.updateScript = gitUpdater { };

  meta = with lib; {
    description = "Flat and colorful personality icon theme";
    homepage = "https://github.com/vinceliuice/Tela-circle-icon-theme";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
