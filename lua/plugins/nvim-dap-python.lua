return {
    "mfussenegger/nvim-dap-python",
    config = function()
        local dap = require "dap"

        -- Python adapter setup
        dap.adapters.python = function(cb, config)
            if config.request == "attach" then
                ---@diagnostic disable-next-line: undefined-field
                local port = (config.connect or config).port
                ---@diagnostic disable-next-line: undefined-field
                local host = (config.connect or config).host or "127.0.0.1"
                cb {
                    type = "server",
                    port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                    host = host,
                    options = {
                        source_filetype = "python",
                    },
                }
            else
                cb {
                    type = "executable",
                    command = "python",
                    args = { "-m", "debugpy.adapter" },
                    options = {
                        source_filetype = "python",
                    },
                }
            end
        end

        -- Configuration for launching the Python script
        dap.configurations.python = {
            {
                type = "python",
                request = "launch",
                name = "Launch File",
                program = "${file}", -- Runs the current file
                pythonPath = function()
                    -- Use the Python in the current virtualenv if available
                    local venv_path = os.getenv "VIRTUAL_ENV"
                    if venv_path then
                        return venv_path .. "/Scripts/python"
                    else
                        return "python" -- Fallback to system Python
                    end
                end,
            },
        }
    end,
}
