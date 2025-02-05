return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            indent = {
                only_scope = true,
                enabled = true,
                animate = { enabled = false },
                scope = { only_current = true },
                chunk = { enabled = true, only_current = true, char = { arrow = "─" } }
            },
            picker = {
                ui_select = true,
                preview = false,
                layout = {
                    layout = {
                        box = "vertical",
                        backdrop = false,
                        row = -1,
                        width = 0,
                        height = 0.4,
                        border = "none",
                        title = " {title} {live} {flags}",
                        title_pos = "left",
                        { win = "input", height = 1, border = "none" },
                        {
                            box = "horizontal",
                            { win = "list",    border = "none" },
                            { win = "preview", title = "{preview}", width = 0.6, border = "left" },
                        },
                    },
                },
                -- layout = {
                --     preset = "ivy",
                --     border = "none",
                -- },
            }
        }
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp', "williamboman/mason.nvim", },

        opts = {
            servers = {
                pyright = {},
                rust_analyzer = {},
                clangd = {},
                ts_ls = {},
                csharp_ls = {},
                gopls = {},
            }
        },
        config = function(_, opts)
            local lspconfig = require('lspconfig')
            -- luals doesnt see the vim global
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {
                                'vim',
                                'require'
                            },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                    },
                },
            }
            for server, config in pairs(opts.servers) do
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end
    },
    {
        "xzbdmw/colorful-menu.nvim" },
    {
        'saghen/blink.cmp',
        lazy = false,
        dependencies = 'rafamadriz/friendly-snippets',

        version = 'v0.*',
        opts = {
            keymap = { preset = 'enter' },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },

            completion = {
                menu = {
                    draw = {
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                width = { fill = true, max = 110 },
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets' },
                cmdline = {},
            },

            signature = { enabled = true }
        },
        opts_extend = { "sources.completion.enabled_providers" }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "bash", "c", "html", "lua", "markdown", "vim", "vimdoc" },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    node_incremental = "|",
                    node_decremental = "\\",
                },
            },
        },
        config = function(_, opts)
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        config = function()
            require("trouble").setup({
                auto_preview = false,
                auto_fold = true,
                use_lsp_diagnostic_signs = true,
            })
        end,
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = true,
        ft = "markdown",

        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    },
    {
        "folke/which-key.nvim",
        event = "VimEnter",
        config = function()
            local wk = require("which-key")
            local binds = require("keybinds")
            wk.setup({
                preset = "helix",
                win = { border = "none" },
                delay = 0,
            })
            wk.add(binds.__pre)
            wk.add(binds.main)
        end,
    },
    {
        "ibhagwan/fzf-lua",
        config = function()
            require("fzf-lua").setup({ "fzf-native", winopts = { backdrop = false, split = "belowright new" } })
        end
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", opt = false },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "|", right = "|" },
                    section_separators = { left = " ", right = " " },
                    disabled_filetypes = {
                        statusline = { "NvimTree", "neo-tree" },
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 10,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { {
                        "mode",
                        fmt = function(res)
                            return res:sub(1, 1)
                        end,
                    } },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "fileformat", "filetype" },
                    lualine_y = { function()
                        local client_text = ""
                        for _, client in ipairs(vim.lsp.get_clients()) do
                            client_text = "LSP: " .. client_text .. client.name
                        end
                        return client_text
                    end, },
                    lualine_z = { "location" },
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({
                progress = {
                    display = {
                        render_limit = 5,
                    },
                },
                notification = {
                    window = {
                        max_width = 40,
                    },
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "│" },
                topdelete = { text = "│" },
                changedelete = { text = "│" },
            },
        },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        init = function()
            vim.cmd.colorscheme("catppuccin")
            vim.cmd.hi("Comment gui=none")
        end,
        config = function()
            require("catppuccin").setup({
                flavour = "auto",
                background = {
                    dark = "mocha",
                },
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    numbers = { "bold" },
                    types = { "bold" },
                    operators = { "bold" },
                },
                color_overrides = {},
                custom_highlights = {},
                default_integrations = true,
                integrations = {
                    gitsigns = true,
                    treesitter = true,
                    notify = false,
                },
            })

            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
