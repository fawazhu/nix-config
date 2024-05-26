{config, ...}: let
  terminal = "alacritty";
  catppuccinFlavour = "macchiato";
in {
  imports = [
    ../../modules/home-manager/my-desktop
    ../../modules/home-manager/my-dev
    ../../modules/home-manager/my-shell
  ];

  home.username = "fawaz";
  home.homeDirectory = "/home/fawaz";

  sops.defaultSopsFile = ./fawaz-secrets.yaml;
  sops.age.keyFile = "/home/fawaz/.config/sops/age/keys.txt";

  sops.secrets.ssh_private_key = {
    mode = "0400";
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
  };
  sops.secrets.ssh_public_key = {
    mode = "0400";
    path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
  };

  my-dev = {
    enable = true;
    terminal = terminal;
    catppuccinFlavour = catppuccinFlavour;
    languages = {
      ansible.enable = true;
      bash.enable = true;
      css.enable = true;
      docker.enable = true;
      go.enable = true;
      graphql.enable = true;
      html.enable = true;
      javascript.enable = true;
      json.enable = true;
      lua.enable = true;
      markdown.enable = true;
      nix.enable = true;
      packer.enable = true;
      python.enable = true;
      rust.enable = true;
      terraform.enable = true;
      toml.enable = true;
      xml.enable = true;
      yaml.enable = true;
    };
    tools = {
      awscli.enable = true;
      lazygit.enable = true;
      codeium.enable = false;
      tabnine.enable = true;
    };
  };
  my-shell = {
    enable = true;
    git = {
      userName = "Fawaz Hussain";
      userEmail = "fawazsana@gmail.com";
    };
    editor = "nvim";
    terminal = terminal;
    catppuccinFlavour = catppuccinFlavour;
  };
  my-desktop = {
    enable = true;
    catppuccinFlavour = catppuccinFlavour;
    scaleFactor = "1.25";
    cursorSize = 32;
    services.kdeconnect.enable = true;
    apps.alacritty = {
      args = "[\"-ci\", \"tmux\"]";
      shell = "zsh";
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
