{ pkgs, ... }: {
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
      credential = {
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
        credentialStore = "secretservice";
      };
    };
  };
  home.packages = with pkgs; [
    git-credential-manager
  ];
}
