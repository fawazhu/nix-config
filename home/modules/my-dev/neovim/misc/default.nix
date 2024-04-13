{ pkgs, ... }: {
  imports = [ ./tabnine.nix ];

  programs.neovim.plugins = with pkgs.vimPlugins; [
    undotree
    trouble-nvim
    indent-blankline-nvim
  ];
  xdg.configFile."nvim/after/plugin/indent_blankline.lua".source = ./indent_blankline.lua;
  xdg.configFile."nvim/after/plugin/trouble.lua".source = ./trouble.lua;
  xdg.configFile."nvim/after/plugin/undotree.lua".source = ./undotree.lua;
} 
