local config = require 'config'
if config.Plugins.copilot == 'copilot' then
    return {
        'github/copilot.vim',
        config = function()
            vim.keymap.set('i', '<C-g>', 'copilot#Accept("\\<CR>")',
                { expr = true, replace_keycodes = false, silent = true })
            vim.g.copilot_no_tab_map = true
        end,
    }
elseif config.Plugins.copilot == "codeium" then
    return {
        'Exafunction/codeium.vim',
        config = function()
            -- Change '<C-g>' here to any keycode you like.
            vim.keymap.set('i', '<C-g>', function()
                return vim.fn['codeium#Accept']()
            end, { expr = true, silent = true })
            vim.keymap.set('i', '<c-;>', function()
                return vim.fn['codeium#CycleCompletions'](1)
            end, { expr = true, silent = true })
            vim.keymap.set('i', '<c-,>', function()
                return vim.fn['codeium#CycleCompletions'](-1)
            end, { expr = true, silent = true })
            vim.keymap.set('i', '<c-x>', function()
                return vim.fn['codeium#Clear']()
            end, { expr = true, silent = true })
        end,
    }
else
    return {}
end
