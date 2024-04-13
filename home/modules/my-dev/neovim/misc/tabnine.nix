{ config, pkgs, ... }: let
  tabnine-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "tabnine-nvim";
    version = "2024-04-11";
    src = pkgs.fetchFromGitHub {
      owner = "codota";
      repo = "tabnine-nvim";
      rev = "2a11f69da0140fcf1a32afa9de790dce930ebd66";
      sha256 = "omvqG4q4/8xyv3NP7I2HNAFd8S7zd2UNH5S8ijhdjXA=";
      fetchSubmodules = true;
    };
  };
in {
  home.packages = if config.my-dev.tools.tabnine.enable then [ pkgs.tabnine ] else [];
  programs.neovim.plugins = if config.my-dev.tools.tabnine.enable then [ tabnine-nvim ] else [];
  xdg.configFile."nvim/after/plugin/tabnine.lua" = if config.my-dev.tools.tabnine.enable then { source = ./tabnine.lua; } else {};
}
