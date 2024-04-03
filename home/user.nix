{ ... }: {
  home.username = "fawaz";
  home.homeDirectory = "/home/fawaz";

  xdg = {
    enable = true;
    userDirs.enable = true;
    userDirs.createDirectories = true;
  };
}
