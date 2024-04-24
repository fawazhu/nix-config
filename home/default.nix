{...}: {
  imports = [
    ./modules/my-dev
    ./modules/my-shell
    ./ssh.nix
    ./user.nix
    ./apps
    ./desktop
    ./sops
  ];

  my-dev = {
    enable = true;
    terminal = "alacritty";
    catppuccin-flavour = "mocha";
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
      codeium.enable = true;
    };
  };
  my-shell = {
    enable = true;
    git = {
      userName = "Fawaz Hussain";
      userEmail = "fawazsana@gmail.com";
    };
    editor = "nvim";
    terminal = "alacritty";
    catppuccin-flavour = "mocha";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
