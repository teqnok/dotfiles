local config = require 'config'
if config.Plugins.treesitter_enabled == false then
    return {}
else
    return {
        { -- Highlight, edit, and navigate code
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            opts = {
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            },
            config = function(_, opts)
                ---@diagnostic disable-next-line: missing-fields
                require('nvim-treesitter.configs').setup(opts)
            end,
        },
    }
end
