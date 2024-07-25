local config = require 'config'
if config.Plugins.explorer == 'neo-tree' then
    return {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            require("neo-tree").setup({
                source_selector = {
                    winbar = true,
                },
                close_if_last_window = true,
            })
        end,
    }
elseif config.Plugins.explorer == 'nvim-tree' then
    return {
        'nvim-tree/nvim-tree.lua',
        version = 'nightly',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        config = function()
            require('nvim-tree').setup {
                filters = {
                    dotfiles = false,
                },
                disable_netrw = true,
                hijack_netrw = true,
                hijack_cursor = true,
                hijack_unnamed_buffer_when_opening = false,
                sync_root_with_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = false,
                },
                view = {
                    adaptive_size = true,
                    side = 'left',
                    width = 30,
                    preserve_window_proportions = true,
                },
                git = {
                    enable = true,
                    ignore = true,
                },
                filesystem_watchers = {
                    enable = true,
                },
                actions = {
                    open_file = {
                        resize_window = true,
                    },
                },
                renderer = {
                    root_folder_label = false,
                    highlight_git = true,
                    highlight_opened_files = 'none',

                    indent_markers = {
                        enable = true,
                    },

                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                        },

                        glyphs = {
                            default = '󰈚',
                            symlink = '',
                            folder = {
                                default = '',
                                empty = '',
                                empty_open = '',
                                open = '',
                                symlink = '',
                                symlink_open = '',
                                arrow_open = '',
                                arrow_closed = '',
                            },
                            git = {
                                unstaged = '✗',
                                staged = '✓',
                                unmerged = '',
                                renamed = '➜',
                                untracked = '★',
                                deleted = '',
                                ignored = '◌',
                            },
                        },
                    },
                },
            }
        end,
    }
else
    return {}
end