-- VSCode-style tab bar


local config = require('config')
if config.Plugins.bufferline == "buffertabs" then
    return {
        'tomiis4/BufferTabs.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        lazy = false,
        config = function()
            require('buffertabs').setup({
                -- config
            })
        end
    }
elseif config.Plugins.bufferline == "nvim-bufferline" then
    return {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.opt.termguicolors = true
            require("bufferline").setup {}
        end,
    }
elseif config.Plugins.bufferline == "barbar" then
    return {
        'romgrk/barbar.nvim',
        config = function()
            require('bufferline').setup {}
        end
    }
else
    return {}
end
