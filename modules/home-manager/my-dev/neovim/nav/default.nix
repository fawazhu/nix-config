{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my-dev.enable {
    programs.neovim.plugins = with pkgs.vimPlugins; [
      harpoon
      nvim-tree-lua
      nvim-web-devicons
      telescope-nvim
      telescope-ui-select-nvim
      trouble-nvim
    ];
    xdg.configFile."nvim/after/plugin/harpoon.lua".source = ./harpoon.lua;
    xdg.configFile."nvim/after/plugin/quickfix.lua".source = ./quickfix.lua;
    xdg.configFile."nvim/after/plugin/telescope.lua".source = ./telescope.lua;
    xdg.configFile."nvim/after/plugin/tree.lua".source = ./tree.lua;
    xdg.configFile."nvim/after/plugin/trouble.lua".source = ./trouble.lua;
  };
}
