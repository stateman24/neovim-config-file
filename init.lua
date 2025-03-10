vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
    },

    { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.g.dashboard = true
vim.schedule(function()
    require "mappings"
end)

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = "LspAttach_inlayhints",
    callback = function(args)
        if not (args.data and args.data.client_id) then
            return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require("lsp-inlayhints").on_attach(client, bufnr)
    end,
})
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.g.python3_host_prog = "C:/Python312/python.exe"

vim.notify = require("notify")

vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        vim.notify("File saved!", "info", { timeout = 2000 })
    end,
})


vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    vim.notify("Entering command mode", "info", { timeout = 2000 })
  end
})

vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local level = ({
    "ERROR",
    "WARN",
    "INFO",
    "DEBUG",
  })[result.type]
  vim.notify(result.message, level, {
    title = client and client.name or "LSP",
  })
end

