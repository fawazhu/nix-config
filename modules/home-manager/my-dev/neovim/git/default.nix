{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my-dev.enable {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      gitsigns-nvim
    ];

    xdg.configFile."nvim/after/plugin/git.lua".source = ./git.lua;
  };
}
