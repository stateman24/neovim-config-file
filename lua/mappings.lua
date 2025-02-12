require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })
map("n", "<leader>gf", vim.lsp.buf.format, {})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- DAP key mappings
map("n", "<Leader>db", function()
    require("dap").toggle_breakpoint()
end, { desc = "toggle_breakpoint_debugger" })

map("n", "<leader>dc", function()
    require("dap").continue()
end, { desc = "Debug Continue" })

map("n", "<leader>do", function()
    require("dap").step_over()
end, { desc = "Debug Step_Over" })

map("n", "<leader>di", function()
    require("dap").step_into()
end, { desc = "Debug Step_Into" })

map("n", "<leader>dO", function()
    require("dap").step_out()
end, { desc = "Debug Step_Out" })

--     vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
--     vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
--     vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
--     vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
--     vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
--       require('dap.ui.widgets').hover()
--     end)
--     vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
--       require('dap.ui.widgets').preview()
--     end)
--     vim.keymap.set('n', '<Leader>df', function()
--       local widgets = require('dap.ui.widgets')
--       widgets.centered_float(widgets.frames)
--     end)
--     vim.keymap.set('n', '<Leader>ds', function()
--       local widgets = require('dap.ui.widgets')
--       widgets.centered_float(widgets.scopes)
--     end)
