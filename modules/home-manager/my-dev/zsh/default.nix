{
  config,
  lib,
  pkgs,
  ...
}: let
  flavour = config.my-dev.catppuccinFlavour;
  captializedFlavour = (lib.toUpper (builtins.substring 0 1 flavour)) + (builtins.substring 1 (-1) flavour);
  awscli2 = pkgs.awscli2.overrideAttrs (oldAttrs: {
    postPatch = ''
      substituteInPlace pyproject.toml \
        --replace-fail 'flit_core>=3.7.1,<3.9.1' 'flit_core>=3.7.1' \
        --replace-fail 'awscrt>=0.19.18,<=0.22.0' 'awscrt>=0.22.0' \
        --replace-fail 'cryptography>=40.0.0,<43.0.2' 'cryptography>=43.0.0' \
        --replace-fail 'distro>=1.5.0,<1.9.0' 'distro>=1.5.0' \
        --replace-fail 'docutils>=0.10,<0.20' 'docutils>=0.10' \
        --replace-fail 'prompt-toolkit>=3.0.24,<3.0.39' 'prompt-toolkit>=3.0.24'
      substituteInPlace requirements-base.txt \
        --replace-fail "wheel==0.43.0" "wheel>=0.43.0"
      # Upstream needs pip to build and install dependencies and validates this
      # with a configure script, but we don't as we provide all of the packages
      # through PYTHONPATH
      sed -i '/pip>=/d' requirements/bootstrap.txt
    '';
  });
in {
  xdg.configFile."zsh/default".source = ./config;
  xdg.configFile."zsh/custom.sh".text = config.my-dev.extraScript;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
      export EDITOR=nvim
      export TERM=alacritty
      export BAT_THEME="Catppuccin ${captializedFlavour}"

      for rc in ~/.config/zsh/default/*; do
        . $rc
      done
      . ~/.config/zsh/custom.sh
      . ${awscli2}/bin/aws_zsh_completer.sh
    '';
  };

  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
}
