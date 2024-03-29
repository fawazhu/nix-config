require("lazy").setup({
    -- Languages / syntax.
    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    -- GUI / Themes
    { "catppuccin/nvim", name = "catppuccin" },
    { "nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    "ThePrimeagen/harpoon",
    -- Utilities
    "mbbill/undotree",
    { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    "lukas-reineke/indent-blankline.nvim",
    -- Git
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",
    "sindrets/diffview.nvim",
    -- Assistants
    { "codota/tabnine-nvim", build = "./dl_binaries.sh" },
})
