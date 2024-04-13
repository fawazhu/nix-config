{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    telescope-nvim
    nvim-tree-lua
    harpoon
    nvim-web-devicons
  ];
  xdg.configFile."nvim/after/plugin/harpoon.lua".source = ./harpoon.lua;
  xdg.configFile."nvim/after/plugin/telescope.lua".source = ./telescope.lua;
  xdg.configFile."nvim/after/plugin/tree.lua".source = ./tree.lua;
}
