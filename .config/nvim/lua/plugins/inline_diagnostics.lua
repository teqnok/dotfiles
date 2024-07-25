local config = require 'config'

if config.Plugins.inline_diagnostics then
    return {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        config = function()
            require('tiny-inline-diagnostic').setup()
        end
    }
else
    return {}
end
