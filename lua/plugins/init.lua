return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
    {
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("lsp-inlayhints").setup()
        end,
    },
    { "nvzone/volt", lazy = true },

    {
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
    },
    { "nvzone/menu", lazy = true },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup {
                stages = "fade",
                timeout = 3000,
                background_colour = "#000000",
                top_down = true, -- Set to false if you want notifications at the top
            }
            vim.notify = require "notify"
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup {
                size = 20,
                open_mapping = [[<C-\>]],
                direction = "float", -- Makes it a floating terminal
                shell = vim.o.shell,
            }
        end,
    },
}
