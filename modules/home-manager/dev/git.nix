{pkgs, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      credential = {
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
        credentialStore = "secretservice";
      };
    };
  };
  home.packages = [
    pkgs.git-credential-manager
  ];
}
