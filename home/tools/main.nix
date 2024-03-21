{ ... }: {
  imports = [
    ./btop.nix
    ./git.nix
    ./ssh.nix
    ./utils.nix
    ./dev/main.nix
    ./tmux/main.nix
    ./zsh/main.nix
  ];
}
