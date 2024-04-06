{ ... }: {
  imports = [ ./modules/my-shell ];

  my-shell = {
    enable = true;
    git = {
      userName = "Fawaz Hussain";
      userEmail = "fawazsana@gmail.com";
    };
    editor = "nvim";
    terminal = "alacritty";
    catppuccin-flavour = "latte";
  };
}
