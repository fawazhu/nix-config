{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    catppuccin-nvim
    lualine-nvim
    noice-nvim
    nvim-notify
  ];
  xdg.configFile."nvim/after/plugin/lualine.lua".source = ./lualine.lua;
  xdg.configFile."nvim/after/plugin/noice.lua".source = ./noice.lua;
  xdg.configFile."nvim/after/plugin/notify.lua".source = ./notify.lua;
  xdg.configFile."nvim/after/plugin/theme.lua".text = ''
    require("catppuccin").setup({
        integrations = {
            cmp = true,
            gitsigns = true,
            harpoon = true,
            indent_blankline = {
                enabled = true,
                scope_color = "${config.my-dev.catppuccinAccent}",
                colored_indent_levels = false,
            },
            lsp_trouble = true,
            mason = true,
            nvimtree = true,
            telescope = true,
            treesitter = true
        }
    })
    vim.cmd.colorscheme "catppuccin-${config.my-dev.catppuccinFlavour}"
  '';
}
