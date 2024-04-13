{ config, pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    catppuccin-nvim
    lualine-nvim
  ];
  xdg.configFile."nvim/after/plugin/lualine.lua".source = ./lualine.lua;
  xdg.configFile."nvim/after/plugin/theme.lua".source = ./theme.lua;
  xdg.configFile."nvim/after/plugin/flavour.lua".text = ''
    vim.cmd.colorscheme "catppuccin-${config.my-dev.catppuccin-flavour}"
  '';
}
