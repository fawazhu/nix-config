{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    flash-nvim
    harpoon
    nvim-tree-lua
    nvim-web-devicons
    plenary-nvim
    telescope-nvim
    telescope-ui-select-nvim
  ];
  xdg.configFile."nvim/after/plugin/diagnostic.lua".source = ./diagnostic.lua;
  xdg.configFile."nvim/after/plugin/flash.lua".source = ./flash.lua;
  xdg.configFile."nvim/after/plugin/harpoon.lua".source = ./harpoon.lua;
  xdg.configFile."nvim/after/plugin/quickfix.lua".source = ./quickfix.lua;
  xdg.configFile."nvim/after/plugin/telescope.lua".source = ./telescope.lua;
  xdg.configFile."nvim/after/plugin/tree.lua".source = ./tree.lua;
}
