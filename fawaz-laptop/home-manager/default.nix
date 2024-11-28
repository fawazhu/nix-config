{config, pkgs, ...}: let
  terminal = "alacritty";
  catppuccinFlavour = "macchiato";
in {
  imports = [
    ../../modules/home-manager/my-apps
    ../../modules/home-manager/my-desktop
    ../../modules/home-manager/my-dev
    ../../modules/home-manager/my-shell
  ];

  home.username = "fawaz";
  home.homeDirectory = "/home/fawaz";

  sops.defaultSopsFile = ../secrets.yaml;
  sops.age.keyFile = "/etc/sops/age/keys.txt";

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
      hcpvault.enable = false;
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
  my-apps = {
    enable  = true;
    catppuccinFlavour = catppuccinFlavour;
    alacritty = {
      enable = true;
      args = "[\"-ci\", \"tmux\"]";
      shell = "zsh";
    };
    packages = with pkgs; [
      seahorse
      nautilus
      file-roller
      gparted
    ];
    flatpak.packages = [
      "ca.desrt.dconf-editor//stable"
      "com.github.tchx84.Flatseal//stable"
      "org.gnome.Calculator//stable"
      "org.gnome.Loupe//stable"
      "org.gnome.baobab//stable"
      "org.gnome.font-viewer//stable"
      "org.inkscape.Inkscape//stable"
      "org.mozilla.firefox//stable"
      "org.onlyoffice.desktopeditors//stable"
      "org.gnome.Calendar//stable"
      "org.gnome.Evince//stable"
      "org.gnome.Totem//stable"
      "io.bassi.Amberol//stable"
      "org.kde.krita//stable"
      "org.kde.kdenlive//stable"
      "org.videolan.VLC//stable"
      "com.brave.Browser//stable"
      "org.libreoffice.LibreOffice//stable"
      "org.blender.Blender//stable"
      "com.calibre_ebook.calibre//stable"
      "com.usebottles.bottles//stable"
      "org.freedesktop.Platform.VulkanLayer.gamescope//23.08"
    ];
    mimeDefaults = {
      enable = true;
      archive = "org.gnome.FileRoller.desktop";
      browser = "org.mozilla.firefox.desktop";
      calendar = "com.calibre_ebook.calibre.desktop";
      document = "org.libreoffice.LibreOffice.desktop";
      ebook = "com.calibre_ebook.calibre.desktop";
      editor = "nvim.desktop";
      font = "org.gnome.font-viewer.desktop";
      image = "org.gnome.Loupe.desktop";
      music = "io.bassi.Amberol.desktop";
      pdf = "org.gnome.Evince.desktop";
      video = "org.gnome.Totem.desktop";
    };
    services.kdeconnect.enable = true;
  };
  my-desktop = {
    enable = true;
    catppuccinFlavour = catppuccinFlavour;
    scaleFactor = "1.25";
    cursorSize = 32;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
