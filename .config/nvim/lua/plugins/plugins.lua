return {
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp', "williamboman/mason.nvim", },

        -- example using `opts` for defining servers
        opts = {
            servers = {
                lua_ls = {},
                rust_analyzer = {},
                clangd = {},
                tsserver = {},
                csharp_ls = {},
            }
        },
        config = function(_, opts)
            local lspconfig = require('lspconfig')
            for server, config in pairs(opts.servers) do
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                lspconfig[server].setup(config)
            end
        end
    },
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
            sources = {
                completion = {
                    enabled_providers = { 'lsp', 'path', 'snippets', 'buffer' },
                },
            },

            completion = {
                menu = {
                    draw = {
                        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
                    },
                },
                accept = { auto_brackets = { enabled = true } }
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
                delay = 0,
            })
            wk.add(binds.__pre)
            wk.add(binds.main)
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",

            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },

            { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
        },
        config = function()
            pcall(require("telescope").load_extension, "cmdline")
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")
        end,
    },{
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
                        statusline = 1000,
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
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "lsp_progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },
    {
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("lsp-inlayhints").setup()
        end,
        init = function()
            vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
            vim.api.nvim_create_autocmd("LspAttach", {
                group = "LspAttach_inlayhints",
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end

                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require("lsp-inlayhints").on_attach(client, bufnr)
                end,
            })
        end,
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        config = function()
            require("tiny-inline-diagnostic").setup({
                signs = {
                    left = "",
                    right = "",
                    diag = "●",
                    arrow = "    ",
                    up_arrow = "    ",
                    vertical = " ",
                    vertical_end = " ",
                },
                hi = {
                    error = "DiagnosticError",
                    warn = "DiagnosticWarn",
                    info = "DiagnosticInfo",
                    hint = "DiagnosticHint",
                    arrow = "NonText",
                    background = "CursorLine",
                    mixing_color = "None",
                },
                blend = {
                    factor = 0.27,
                },
                options = {
                    show_source = true,
                    throttle = 20,
                    softwrap = 15,
                    multilines = true,

                    overflow = {
                        mode = "wrap",
                    },
                    format = function(diagnostic)
                        return diagnostic.message .. " [" .. diagnostic.source .. "]"
                    end,
                    break_line = {
                        enabled = false,
                        after = 30,
                    },
                    virt_texts = {
                        priority = 2048,
                    },
                    severity = {
                        vim.diagnostic.severity.ERROR,
                        vim.diagnostic.severity.WARN,
                        vim.diagnostic.severity.INFO,
                        vim.diagnostic.severity.HINT,
                    },

                    overwrite_events = nil,
                },
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
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Explorer",
                        highlight = "Directory",
                        text_align = "center",
                    },
                },
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
            })
        end,
    },
    {
        "goolord/alpha-nvim",
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.header.val = {
                [[                                   ]],
                [[                      ( )          ]],
                [[ _ __   ___  _____   ___ _ __ ___  ]],
                [[| '_ \ / _ \/ _ \ \ / / | '_ ` _ \ ]],
                [[| | | |  __/ (_) \ V /| | | | | | |]],
                [[|_| |_|\___|\___/ \_/ |_|_| |_| |_|]],
                [[                                   ]],
                [[          version 0.10.0           ]],
            }
            dashboard.section.buttons.val = {
                dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
                dashboard.button("t", "󰺮  Find text", ":Telescope live_grep<CR>"),
                dashboard.button("u", "  Update plugins", ":Lazy update<CR>"),
                dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
                dashboard.button("l", "󰏖  Lazy", ":Lazy<CR>"),
                dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h<CR>"),
                dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
            }

            dashboard.config.opts.noautocmd = true

            alpha.setup(dashboard.config)
        end,
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
                flavour = "auto", -- latte, frappe, macchiato, mocha
                background = {
                    dark = "mocha",
                },
                transparent_background = false, -- disables setting the background color.
                show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.15,
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
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                },
            })

            -- setup must be called before loading
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "github/copilot.vim",
        config = function() end,
    },
}
