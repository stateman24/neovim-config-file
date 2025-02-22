return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require "none-ls"
        null_ls.setup {
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.black,
            },
        }
    end,
}
