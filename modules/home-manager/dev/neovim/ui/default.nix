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
        custom_highlights = function(colors)
            return {
                Directory = { fg = colors.${config.theming.accent} },
                Folded = { fg = colors.${config.theming.accent} },
                MoreMsg = { fg = colors.${config.theming.accent} },
                FloatBorder = { fg = colors.${config.theming.accent} },
                Question = { fg = colors.${config.theming.accent} },
                Title = { fg = colors.${config.theming.accent} },
                WinBar = { fg = colors.${config.theming.accent} },
                HarpoonBorder = { fg = colors.${config.theming.accent} },
                NoiceCmdlineIcon = { fg = colors.${config.theming.accent} },
                NoiceCmdlinePopupBorder = { fg = colors.${config.theming.accent} },
                NoiceConfirmBorder = { fg = colors.${config.theming.accent} },
                NvimTreeFolderName = { fg = colors.${config.theming.accent} },
                NvimTreeFolderIcon = { fg = colors.${config.theming.accent} },
                NvimTreeOpenedFolderName = { fg = colors.${config.theming.accent} },
                NvimTreeEmptyFolderName = { fg = colors.${config.theming.accent} },
                NvimTreeRootFolder = { fg = colors.${config.theming.accent} },
                TelescopeSelectionCaret = { fg = colors.${config.theming.accent} },
                TelescopeMatching = { fg = colors.${config.theming.accent} },
            }
        end,
        integrations = {
            cmp = true,
            gitsigns = true,
            harpoon = true,
            indent_blankline = {
                enabled = true,
                scope_color = "${config.theming.accent}",
                colored_indent_levels = false,
            },
            lsp_trouble = true,
            nvimtree = true,
            telescope = true,
            treesitter = true
        }
    })
    vim.cmd.colorscheme "catppuccin-${config.theming.flavour}"
  '';
}
