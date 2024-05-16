{pkgs, ...}:
with pkgs;
  stdenv.mkDerivation (finalAttrs: {
    pname = "catppuccin-tmux";
    version = "cece0c36772483d1343bcace2b1cedb007057c2e";

    src = fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "cece0c36772483d1343bcace2b1cedb007057c2e";
      sha256 = "sha256-dB2bS/TG0ptXCCTfrm75xaDLaA29SYV5cv77YqSdLRk=";
    };

    installPhase = ''
      mkdir -p $out/share/tmux-plugins
      cp -r . $out/share/tmux-plugins/catppuccin
    '';
  })
