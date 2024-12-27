{
  lib,
  pkgs,
  ...
}: let
  granted = pkgs.granted.overrideAttrs {env.CGO_ENABLED = 0;};
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
  options.my-dev = import ./options.nix {inherit lib;};

  config = {
    home.packages = with pkgs; [
      # Cloud tools
      awscli2
      aws-vault
      granted
      # Git tools
      lazygit
      pre-commit
      # Vault
      vault-bin
      # Data manipulation
      jq
      xq-xml
      yq-go
      # Search / file management
      eza
      fd
      fzf
      ripgrep
      rsync
      # Networking
      dig
      openssl_3_3
      socat
      tcpdump
      # Multimedia tools
      ffmpeg_7-full
      graphviz
      imagemagick
      # Container tools
      podman-compose
    ];
    services.podman.enable = true;
  };

  imports = [
    ./alacritty.nix
    ./bat.nix
    ./btop.nix
    ./git.nix
    ./nushell.nix
    ./neovim
    ./tmux
    ./zsh
  ];
}
