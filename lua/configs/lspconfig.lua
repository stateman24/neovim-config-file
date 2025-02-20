-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
-- EXAMPLE
local servers = { "html", "cssls", "ts_ls", "djlsp", "pyright", "jdtls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = function(client, bufnr)
            if nvlsp.on_attach then
                nvlsp.on_attach(client, bufnr)
            end

            -- Auto format on save
            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format { bufnr = bufnr }
                    end,
                })
            end

            -- Auto-import on completion
            if client.server_capabilities.completionProvider then
                local cmp = require "cmp"
                cmp.setup {
                    mapping = {
                        ["<CR>"] = cmp.mapping.confirm { select = true }, -- Auto-complete on Enter
                    },
                    sources = {
                        { name = "nvim_lsp" },
                        { name = "buffer" },
                        { name = "path" },
                    },
                }
            end

            -- Inlay hint
            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, {bufnr})
            end
        end,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
    }
end

lspconfig.djlsp.setup {
    cmd = { "djlsp", "--stdio" },
    filetypes = { "htmldjango" }, -- Recognize Django HTML files
    root_dir = lspconfig.util.root_pattern("manage.py", "pyproject.toml"),
    capabilities = nvlsp.capabilities,
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
