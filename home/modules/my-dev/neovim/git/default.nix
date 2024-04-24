{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    diffview-nvim
    vim-fugitive
    gitsigns-nvim
  ];

  xdg.configFile."nvim/after/plugin/git.lua".source = ./git.lua;
}
