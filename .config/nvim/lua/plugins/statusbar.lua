local config = require 'config'
if config.Plugins.statusline == 'lualine' then
    return {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = false},
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = ' ', right = ' ' },
                    disabled_filetypes = {
                        statusline = {"NvimTree", "neo-tree"},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { {'mode', fmt = function(res) return res:sub(1,1) end} },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'lsp_progress' },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            }
        end,
    }
elseif config.Plugins.statusline == 'sttusline' then
    return {
        "sontungexpt/sttusline",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = { "BufEnter" },
        config = function(_, opts)
            require("sttusline").setup {
                -- statusline_color = "#000000",
                statusline_color = "StatusLine",
                laststatus = 3,
                disabled = {
                    filetypes = {
                        "NvimTree",
                        "neo-tree"
                        -- "lazy",
                    },
                    buftypes = {
                        -- "terminal",
                    },
                },
                components = {
                    "mode",
                    "filename",
                    "git-branch",
                    "git-diff",
                    "%=",
                    "diagnostics",
                    "lsps-formatters",
                    "copilot",
                    "indent",
                    "encoding",
                    "pos-cursor",
                    "pos-cursor-progress",
                },
            }
        end,
    }
else
    return {}
end
