{pkgs, ...}: {
  xdg.configFile = {
    "btop/themes".source = "${pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "btop";
      rev = "1.0.0";
      sha256 = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
    }}/themes";
  };

  home.packages = [ pkgs.btop ];
}
