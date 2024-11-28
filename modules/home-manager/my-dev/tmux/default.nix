{
  config,
  lib,
  pkgs,
  ...
}: let
  catppuccin-tmux = with pkgs;
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
    });
  tmux-plugins-sensible = with pkgs;
    stdenv.mkDerivation (finalAttrs: {
      pname = "tmux-plugins-sensible";
      version = "v3.0.0";

      src = fetchFromGitHub {
        owner = "tmux-plugins";
        repo = "tmux-sensible";
        rev = finalAttrs.version;
        sha256 = "sha256-ney/Y1YtCsWLgthOmoYGZTpPfJz+DravRB31YZgnDuU=";
      };

      installPhase = ''
        mkdir -p $out/share/tmux-plugins
        cp -r . $out/share/tmux-plugins/tmux-sensible
      '';
    });
in {
  xdg.configFile."tmux/extra.conf".source = ./tmux.conf;
  xdg.configFile."tmux/tmux.conf".text = ''
    source-file ~/.config/tmux/extra.conf
    set -g @catppuccin_flavour ${config.my-dev.catppuccinFlavour}
    set-option -g default-shell ${pkgs.zsh}/bin/zsh
    run '${catppuccin-tmux}/share/tmux-plugins/catppuccin/catppuccin.tmux'
    run '${tmux-plugins-sensible}/share/tmux-plugins/tmux-sensible/sensible.tmux'
  '';
  home.packages = [pkgs.tmux];
}
