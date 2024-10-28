return { { {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim', 'hrsh7th/cmp-nvim-lsp', {
            'folke/neodev.nvim',
            opts = {}
        } },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local servers = {
            rust_analyzer = {},

            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace'
                        },
                        diagnostics = {
                            disable = { 'missing-fields' }
                        }
                    }
                }
            }
        }

        require('mason').setup()

        require('mason-lspconfig').setup {
            handlers = { function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                require('lspconfig')[server_name].setup(server)
            end }
        }
    end
} },{

    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    priority = 1000,
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      cmp.setup({
        window = {
          documentation = { max_height = 15 },
          completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = 1,
            side_padding = 0,
          },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-.>'] = cmp.mapping.select_next_item(),
          ['<C-,>'] = cmp.mapping.select_prev_item(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "<" .. (strings[2] or "") .. ">"

            return kind
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#5b6078", fg = "#cad3f5" })
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#363a4f", fg = "#cad3f5" })

      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#939ab7", bg = "NONE", strikethrough = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#8aadf4", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#8aadf4", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#f5bde6", bg = "NONE", italic = true })
    end,
  },   {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },{
        'folke/trouble.nvim',
        cmd = 'Trouble',
        config = function()
            require('trouble').setup {
                auto_preview = false,
                auto_fold = true,
                use_lsp_diagnostic_signs = true
            }
        end
    }, {
        "OXY2DEV/markview.nvim",
        lazy = true,
        ft = "markdown",

        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }
    }, {
        'Bekaboo/dropbar.nvim',
        dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' }
    }, {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        },
        config = function()
            require("neo-tree").setup({
                source_selector = {
                    sources = { {
                        source = "filesystem"
                    }, {
                            source = "buffers"
                        }, {
                            source = "git_status"
                        } },
                    -- tabs_layout = "center",
                    winbar = true
                },
                close_if_last_window = true
            })
        end
    }, {
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        config = function() -- This is the function that runs, AFTER loading
            local wk = require('which-key')
            local Modes = {
                Visual   = 'v',
                Normal   = 'n',
                Command  = 'c',
                Terminal = 't',
                Select   = 's',
                Insert   = 'i',
                Replace  = 'r',
            }
            wk.setup(
                {
                    preset = "helix",
                    delay = 0,
                }
            )
            -- Document existing key chains
            wk.add(
                {
                    { "<leader>c", group = "Code" },
                    { "<leader>c_", hidden = true },
                    { "<leader>d", group = "Document" },
                    { "<leader>d_", hidden = true },
                    { "<leader>r", group = "Rename" },
                    { "<leader>r_", hidden = true },
                    { "<leader>f", group = "Telescope" },
                    { "<leader>f_", hidden = true },
                    { "<leader>s", group = "Search" },
                    { "<leader>e", group = "Explorer", icon = { icon = "󰪶", color = "green" } },
                    { "<leader>e_", hidden = true },
                    { "<leader>s_", hidden = true },
                    { "<leader>t", group = "Terminal" },
                    { "<leader>t_", hidden = true },
                    { "<leader>w", group = "Workspace" },
                    { "<leader>w_", hidden = true },
                    { "<leader>x", group = "Trouble", icon = { icon = " ", color = "orange" } },
                    { "<leader>x_", hidden = true },
                })
            wk.add({
                { "<leader>n", "<CMD>nohlsearch<CR>",        desc = "Stop search",                mode = Modes.Normal },
                { "<leader>L", "<CMD>Lazy<CR>",              desc = "Lazy",                       mode = Modes.Normal },
                { "d",         '"ad',                        desc = 'Delete to "a',               mode = { Modes.Normal, Modes.Visual }, noremap = true },
                { "<leader>S", "ggVG",                       desc = 'Select All',                 mode = { Modes.Normal, Modes.Visual }, noremap = true },
                { "<leader>p", '"ap',                        desc = "Paste from deletion buffer", mode = { Modes.Normal, Modes.Visual }, noremap = true },
                -- { ";",         "<CMD>Telescope cmdline<CR>", desc = "Cmdline",                    mode = { Modes.Normal },               noremap = true },
                { "<leader>q",  function() vim.lsp.buf.format() end,                      desc = "Format",       mode = Modes.Normal },
                { "<leader>a", function() vim.lsp.buf.code_action() end, desc = " Code Action", mode = Modes.Normal, noremap = true, silent = true },
            
            
                { "<leader>F",  "<CMD>Telescope find_files<CR>",           desc = "Find Files",        mode = Modes.Normal },
                { "<leader>ff", "<CMD>Telescope find_files<CR>",           desc = "Find Files",        mode = Modes.Normal },
                { "<leader>fg", "<CMD>Telescope live_grep<CR>",            desc = "Find with Grep",    mode = Modes.Normal },
                { "<leader>ds", "<CMD>Telescope lsp_document_symbols<CR>", desc = " Document Symbols", mode = Modes.Normal },
                { "<leader>dw",  "<CMD>w<CR>",                  desc = " Document Write",       mode = Modes.Normal },
                { "<leader>dc",  "<CMD>bp|bd#<CR>",            desc = " Document Close",       mode = Modes.Normal },
            
                -- Window management
                { "<C-Left>",    "<CMD>wincmd h<CR>",           desc = " Move to left window",  mode = Modes.Normal },
                { "<C-Down>",    "<CMD>wincmd j<CR>",           desc = " Move to down window",  mode = Modes.Normal },
                { "<C-Right>",   "<CMD>wincmd l<CR>",           desc = " Move to right window", mode = Modes.Normal },
                { "<C-Up>",      "<CMD>wincmd k<CR>",           desc = " Move to up window",    mode = Modes.Normal },
                { "<C-S-Left>",  "<CMD>vertical resize -2<CR>", desc = "Resize window left",    mode = Modes.Normal },
                { "<C-S-Right>", "<CMD>vertical resize +2<CR>", desc = "Resize window right",   mode = Modes.Normal },
                { "<C-S-Up>",    "<CMD>resize +2<CR>",          desc = "Resize window up",      mode = Modes.Normal },
                { "<C-S-Down>",  "<CMD>resize -2<CR>",          desc = "Resize window down",    mode = Modes.Normal },
            
                { "<leader>sh", "<CMD>split<CR>", desc = " Split Horizontal", mode = Modes.Normal },
                { "<leader>sv", "<CMD>vs<CR>",    desc = " Split Vertical",   mode = Modes.Normal },
            
                -- Terminal
            
                { "<leader>T",  "<CMD>ToggleTerm direction=horizontal<CR>", desc = "Terminal",       mode = Modes.Normal },
                { "<leader>tf", "<CMD>ToggleTerm direction=float<CR>",      desc = "Float (center)", mode = Modes.Normal },
                { "<leader>th", "<CMD>ToggleTerm direction=horizontal<CR>", desc = "Bottom",         mode = Modes.Normal },
                { "<leader>tv", "<CMD>ToggleTerm direction=vertical<CR>",   desc = "Sidebar",        mode = Modes.Normal },
            
            
                -- File tree
            
                { "<leader>E",  "<CMD>Neotree toggle<CR>",       desc = "Explorer",        mode = Modes.Normal },
                { "<leader>er", "<CMD>Neotree float right<CR>",  desc = "Explorer Right",  mode = Modes.Normal },
                { "<leader>el", "<CMD>Neotree float left<CR>",   desc = "Explorer Left",   mode = Modes.Normal },
                { "<leader>ec", "<CMD>Neotree float center<CR>", desc = "Explorer Center", mode = Modes.Normal },
            
                -- Buffer lines
                { "<Tab>",   "<CMD>BufferLineCycleNext<CR>", desc = "Next Buffer",     mode = Modes.Normal },
                { "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", desc = "Previous Buffer", mode = Modes.Normal },
            
            
                -- Trouble (Errors)
                { "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Trouble diagnostics (Global)", mode = Modes.Normal },
                { "<leader>xD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Trouble Diagnostics (Buffer)", mode = Modes.Normal },
                { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Trouble Symbols",              mode = Modes.Normal },
                { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Trouble LSP Info",             mode = Modes.Normal },
                { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Trouble Location List",        mode = Modes.Normal },
                { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Trouble Quickfix list",        mode = Modes.Normal }
            })
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        dependencies = {
            'nvim-lua/plenary.nvim',

            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
        },
        config = function()
            pcall(require('telescope').load_extension, 'cmdline')
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')
        end,
    },{
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
    },{'akinsho/toggleterm.nvim', version = "*", config = true},
    {
        'lvimuser/lsp-inlayhints.nvim',
        config = function()
            require('lsp-inlayhints').setup()
        end,
        init = function()
            vim.api.nvim_create_augroup('LspAttach_inlayhints', {})
            vim.api.nvim_create_autocmd('LspAttach', {
                group = 'LspAttach_inlayhints',
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end

                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require('lsp-inlayhints').on_attach(client, bufnr)
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
        end
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require 'fidget'.setup({
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
        'lewis6991/gitsigns.nvim',
        opts = {
          signs = {
            add = { text = '│' },
            change = { text = '│' },
            delete = { text = '│' },
            topdelete = { text = '│' },
            changedelete = { text = '│' },
          },
        },
      },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
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
        'goolord/alpha-nvim',
        config = function()
            local alpha = require 'alpha'
            local dashboard = require 'alpha.themes.dashboard'
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
                dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
                dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
                dashboard.button('t', '󰺮  Find text', ':Telescope live_grep<CR>'),
                dashboard.button('u', '  Update plugins', ':Lazy update<CR>'),
                dashboard.button('r', '  Recent', ':Telescope oldfiles<CR>'),
                dashboard.button('l','󰏖  Lazy', ':Lazy<CR>'),
                dashboard.button('s', '  Settings', ':e $MYVIMRC | :cd %:p:h<CR>'),
                dashboard.button('q', '󰅚  Quit', ':qa<CR>'),
            }

            dashboard.config.opts.noautocmd = true

            alpha.setup(dashboard.config)
        end,
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        init = function()
            vim.cmd.colorscheme 'catppuccin'
            vim.cmd.hi 'Comment gui=none'
        end,
        config = function()
            require("catppuccin").setup({
                flavour = "auto", -- latte, frappe, macchiato, mocha
                background = {
                    dark = "mocha",
                },
                transparent_background = false, -- disables setting the background color.
                show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
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
            vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        'github/copilot.vim',
        config = function()
        end,
    },
}
