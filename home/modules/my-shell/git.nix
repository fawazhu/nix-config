{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my-shell.enable {
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
    home.packages = [
      pkgs.git-credential-manager
    ];
  };
}
