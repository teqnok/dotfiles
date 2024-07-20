local config = require 'config'
if config.Plugins.telescope_enabled == false then
    return {}
else
    return {
        { -- Fuzzy Finder (files, lsp, etc)
            'nvim-telescope/telescope.nvim',
            event = 'VimEnter',
            keys = {
                { ';', '<cmd>Telescope cmdline<cr>', desc = 'Cmdline' },
            },
            branch = '0.1.x',
            dependencies = {
                'nvim-lua/plenary.nvim',
                'jonarrien/telescope-cmdline.nvim',

                { -- If encountering errors, see telescope-fzf-native README for install instructions
                    'nvim-telescope/telescope-fzf-native.nvim',

                    -- `build` is used to run some command when the plugin is installed/updated.
                    -- This is only run then, not every time Neovim starts up.
                    build = 'make',

                    -- `cond` is a condition used to determine whether this plugin should be
                    -- installed and loaded.
                    cond = function()
                        return vim.fn.executable 'make' == 1
                    end,
                },
                { 'nvim-telescope/telescope-ui-select.nvim' },

                -- Useful for getting pretty icons, but requires a Nerd Font.
                { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
            },
            config = function()
                local colors = require('catppuccin.palettes').get_palette()
                local TelescopeColor = {
                    TelescopeMatching = { fg = colors.flamingo },
                    TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

                    TelescopePromptPrefix = { bg = colors.surface0 },
                    TelescopePromptNormal = { bg = colors.surface0 },
                    TelescopeResultsNormal = { bg = colors.mantle },
                    TelescopePreviewNormal = { bg = colors.mantle },
                    TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
                    TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
                    TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
                    TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
                    TelescopeResultsTitle = { fg = colors.mantle },
                    TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
                }

                for hl, col in pairs(TelescopeColor) do
                    vim.api.nvim_set_hl(0, hl, col)
                end
                require('telescope').setup { extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
                }

                -- Enable telescope extensions, if they are installed
                pcall(require('telescope').load_extension, 'cmdline')
                pcall(require('telescope').load_extension, 'fzf')
                pcall(require('telescope').load_extension, 'ui-select')

                vim.keymap.set('n', '<leader>/', function()
                    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = true,
                    })
                end, { desc = '[/] Fuzzily search in current buffer' })

                vim.keymap.set('n', '<leader>s/', function()
                    builtin.live_grep {
                        grep_open_files = true,
                        prompt_title = 'Live Grep in Open Files',
                    }
                end, { desc = '[S]earch [/] in Open Files' })
            end,
        },
    }
end
