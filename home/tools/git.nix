{ ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "fawazsana@gmail.com";
    userName = "Fawaz Hussain";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
