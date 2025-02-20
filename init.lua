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

-- local function run_curr_python_file()
--     -- Get file name in the current buffer
--     local file_name = vim.api.nvim_buf_get_name(0)

--     -- Get terminal codes for running python file
--     -- ("i" to enter insert before typing rest of the command)
--     local py_cmd = vim.api.nvim_replace_termcodes('ipython "' .. file_name .. '"<cr>', true, false, true)

--     -- Determine terminal window split and launch terminal
--     local percent_of_win = 0.4
--     local curr_win_height = vim.api.nvim_win_get_height(0) -- Current window height
--     local term_height = math.floor(curr_win_height * percent_of_win) -- Terminal height
--     vim.cmd(":below " .. term_height .. "split | term") -- Launch terminal (horizontal split)

--     -- Press keys to run python command on current file
--     vim.api.nvim_feedkeys(py_cmd, "t", false)
-- end


