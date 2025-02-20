require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })
map("n", "<leader>gf", vim.lsp.buf.format, {})
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Terimal key mappings
map("t", "<Esc>", [[<C-x>]], { desc = "Move from Terimal Insert to Normal", noremap = true, silent = true })
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

map("n", "<leader>rf", function()
    require("nvchad.term").runner {
        id = "boo",
        pos = "sp",
        cmd = function()
            local file = vim.fn.expand "%"
            local filename_no_ext = vim.fn.fnamemodify(file, ":r")

            -- Define file type commands
            local ft_cmds = {
                python = "python " .. file,
                javascript = "node " .. file,
                cpp = "clear && g++ -o out " .. file .. " && ./out",
                java = "clear && javac " .. file .. " && java " .. filename_no_ext,
            }

            -- Get the current buffer's file type
            local filetype = vim.bo.filetype

            -- Run the appropriate command
            return ft_cmds[filetype] or "echo 'Unsupported file type'"
        end,
    }
end, { desc = "Exceute/Run file" })

-- Keyboard users
map("n", "<leader>om", function()
    require("menu").open "default"
end, { desc = "Open Menu" })

-- mouse users + nvimtree users!
map({ "n", "v" }, "<RightMouse>", function()
    require("menu.utils").delete_old_menus()

    vim.cmd.exec '"normal! \\<RightMouse>"'

    -- clicked buf
    local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
    local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

    require("menu").open(options, { mouse = true })
end, {})
