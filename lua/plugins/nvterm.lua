return {
    {
        "NvChad/nvterm",
        config = function()
            require("nvterm").setup {
                terminals = {
                    type_opts = {
                        float = {
                            relative = "editor",
                            row = 0.3,
                            col = 0.25,
                            width = 0.5,
                            height = 0.4,
                        },
                        horizontal = { location = "bottom", split_ratio = 0.3 },
                        vertical = { location = "right", split_ratio = 0.5 },
                    },
                },
            }
        end,
    },
}
