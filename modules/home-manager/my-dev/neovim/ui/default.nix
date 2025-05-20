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
                Directory = { fg = colors.${config.my-dev.catppuccinAccent} },
                Folded = { fg = colors.${config.my-dev.catppuccinAccent} },
                MoreMsg = { fg = colors.${config.my-dev.catppuccinAccent} },
                FloatBorder = { fg = colors.${config.my-dev.catppuccinAccent} },
                Question = { fg = colors.${config.my-dev.catppuccinAccent} },
                Title = { fg = colors.${config.my-dev.catppuccinAccent} },
                WinBar = { fg = colors.${config.my-dev.catppuccinAccent} },
                HarpoonBorder = { fg = colors.${config.my-dev.catppuccinAccent} },
                NoiceCmdlineIcon = { fg = colors.${config.my-dev.catppuccinAccent} },
                NoiceCmdlinePopupBorder = { fg = colors.${config.my-dev.catppuccinAccent} },
                NoiceConfirmBorder = { fg = colors.${config.my-dev.catppuccinAccent} },
                NvimTreeFolderName = { fg = colors.${config.my-dev.catppuccinAccent} },
                NvimTreeFolderIcon = { fg = colors.${config.my-dev.catppuccinAccent} },
                NvimTreeOpenedFolderName = { fg = colors.${config.my-dev.catppuccinAccent} },
                NvimTreeEmptyFolderName = { fg = colors.${config.my-dev.catppuccinAccent} },
                NvimTreeRootFolder = { fg = colors.${config.my-dev.catppuccinAccent} },
                TelescopeSelectionCaret = { fg = colors.${config.my-dev.catppuccinAccent} },
                TelescopeMatching = { fg = colors.${config.my-dev.catppuccinAccent} },
            }
        end,
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
            nvimtree = true,
            telescope = true,
            treesitter = true
        }
    })
    vim.cmd.colorscheme "catppuccin-${config.my-dev.catppuccinFlavour}"
  '';
}
