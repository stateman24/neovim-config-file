-- Java LSP
return {
    -- https://github.com/mfussenegger/nvim-jdtls
    "mfussenegger/nvim-jdtls",
    ft = "java", -- Enable only on .java file extensions
    config = function()
        local dap = require "dap"
        dap.adapters.java = {
            {
                type = "server",
                request = "attach",
                name = "Debug (Attach) - Remote",
                hostName = "127.0.0.1",
                port = 5005,
            },
        }
        dap.configurations.java = {
            {
                -- You need to extend the classPath to list your dependencies.
                -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
                classPaths = {},

                javaExec = "/path/to/your/bin/java",
                mainClass = "your.package.name.MainClassName",

                -- If using the JDK9+ module system, this needs to be extended
                -- `nvim-jdtls` would automatically populate this property;
                modulePaths = {},
                name = "Launch YourClassName",
                request = "launch",
                type = "java",
            },
        }
    end,
}
