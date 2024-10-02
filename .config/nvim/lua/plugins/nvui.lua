local config = require 'config'
if config.Plugins.nvui_enabled then
    return {
        { lazy = true, "nvim-lua/plenary.nvim"},
        {
            "nvchad/ui",
            config = function()
                require "nvchad" 
            end
        },

        {
            "nvchad/base46",
            lazy = true,
            build = function()
                require("base46").load_all_highlights()
            end,
        },
    }
else return {}
end
