local Modes = {
    Visual   = 'v',
    Normal   = 'n',
    Command  = 'c',
    Terminal = 't',
    Select   = 's',
    Insert   = 'i',
    Replace  = 'r',
}

local config = require 'config'
local wk = require("which-key")

wk.add({
    { "<leader>n", "<CMD>nohlsearch<CR>",        desc = "Stop search",                mode = Modes.Normal },
    { "<leader>L", "<CMD>Lazy<CR>",              desc = "Lazy",                        mode = Modes.Normal },
    { "d",         '"ad',                        desc = 'Delete to "a',                mode = { Modes.Normal, Modes.Visual }, noremap = true },
    { "<leader>p", '"ap',                        desc = "Paste from deletion buffer", mode = { Modes.Normal, Modes.Visual }, noremap = true },
    { ";",         "<CMD>Telescope cmdline<CR>", desc = "Cmdline",                     mode = { Modes.Normal },               noremap = true },
    -- LSP
    config.Options.enable_lsp and {
        { "<leader>q",  function() vim.lsp.buf.format() end,                      desc = "Format",      mode = Modes.Normal },
        { "<leader>ca", function() require("tiny-code-action").code_action() end, desc = " Code Action", mode = Modes.Normal, noremap = true, silent = true }
    },

    -- Telescope
    config.Plugins.telescope_enabled and {
        { "<leader>F",  "<CMD>Telescope find_files<CR>",           desc = "Find Files",        mode = Modes.Normal },
        { "<leader>ff", "<CMD>Telescope find_files<CR>",           desc = "Find Files",        mode = Modes.Normal },
        { "<leader>fg", "<CMD>Telescope live_grep<CR>",            desc = "Find with Grep",    mode = Modes.Normal },
        { "<leader>ds", "<CMD>Telescope lsp_document_symbols<CR>", desc = " Document Symbols", mode = Modes.Normal }
    },

    { "<leader>dw",  "<CMD>w<CR>",                  desc = " Document Write",       mode = Modes.Normal },
    { "<leader>dc",  "<CMD>bdelete<CR>",            desc = " Document Close",       mode = Modes.Normal },

    -- Window management
    { "<C-Left>",    "<CMD>wincmd h<CR>",           desc = " Move to left window",  mode = Modes.Normal },
    { "<C-Down>",    "<CMD>wincmd j<CR>",           desc = " Move to down window",  mode = Modes.Normal },
    { "<C-Right>",   "<CMD>wincmd l<CR>",           desc = " Move to right window", mode = Modes.Normal },
    { "<C-Up>",      "<CMD>wincmd k<CR>",           desc = " Move to up window",    mode = Modes.Normal },
    { "<C-S-Left>",  "<CMD>vertical resize -2<CR>", desc = "Resize window left",    mode = Modes.Normal },
    { "<C-S-Right>", "<CMD>vertical resize +2<CR>", desc = "Resize window right",   mode = Modes.Normal },
    { "<C-S-Up>",    "<CMD>resize +2<CR>",          desc = "Resize window up",      mode = Modes.Normal },
    { "<C-S-Down>",  "<CMD>resize -2<CR>",          desc = "Resize window down",    mode = Modes.Normal },
    config.Options.tmux_integration and {
        { "<C-h>", "<CMD>TmuxNavigateLeft<CR>",  desc = " Window left",  mode = Modes.Normal },
        { "<C-j>", "<CMD>TmuxNavigateDown<CR>",  desc = " Window down",  mode = Modes.Normal },
        { "<C-k>", "<CMD>TmuxNavigateUp<CR>",    desc = " Window up",    mode = Modes.Normal },
        { "<C-l>", "<CMD>TmuxNavigateRight<CR>", desc = " Window right", mode = Modes.Normal }
    },
    { "<leader>sh", "<CMD>split<CR>", desc = " Split Horizontal", mode = Modes.Normal },
    { "<leader>sv", "<CMD>vs<CR>",    desc = " Split Vertical",   mode = Modes.Normal },

    -- Terminal
    config.Plugins.toggleterm_enabled and {
        { "<leader>T",  "<CMD>ToggleTerm direction=horizontal<CR>", desc = "Terminal",       mode = Modes.Normal },
        { "<leader>tf", "<CMD>ToggleTerm direction=float<CR>",      desc = "Float (center)", mode = Modes.Normal },
        { "<leader>th", "<CMD>ToggleTerm direction=horizontal<CR>", desc = "Bottom",         mode = Modes.Normal },
        { "<leader>tv", "<CMD>ToggleTerm direction=vertical<CR>",   desc = "Sidebar",        mode = Modes.Normal },
    },

    -- File tree
    config.Plugins.explorer == 'neo-tree' and {
        { "<leader>E",  "<CMD>Neotree toggle<CR>",       desc = "Explorer",        mode = Modes.Normal },
        { "<leader>er", "<CMD>Neotree float right<CR>",  desc = "Explorer Right",  mode = Modes.Normal },
        { "<leader>el", "<CMD>Neotree float left<CR>",   desc = "Explorer Left",   mode = Modes.Normal },
        { "<leader>ec", "<CMD>Neotree float center<CR>", desc = "Explorer Center", mode = Modes.Normal }
    } or config.Plugins.explorer == 'nvim-tree' and {
        { "<leader>E", "<CMD>NvimTreeToggle<CR>", desc = "Explorer", mode = Modes.Normal },
    },

    -- Buffer lines
    config.Plugins.bufferline == 'barbar' and {
        { "<Tab>",   "<CMD>BufferNext<CR>", desc = "Next Buffer",     mode = Modes.Normal },
        { "<S-Tab>", "<CMD>BufferPrev<CR>", desc = "Previous Buffer", mode = Modes.Normal }
    } or config.Plugins.bufferline == "nvim-bufferline" and {
        { "<Tab>",   "<CMD>BufferLineCycleNext<CR>", desc = "Next Buffer",     mode = Modes.Normal },
        { "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", desc = "Previous Buffer", mode = Modes.Normal }
    },

    -- Trouble (Errors)
    config.Plugins.trouble_enabled and {
        { "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Trouble diagnostics (Global)", mode = Modes.Normal },
        { "<leader>xD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Trouble Diagnostics (Buffer)", mode = Modes.Normal },
        { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Trouble Symbols",              mode = Modes.Normal },
        { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Trouble LSP Info",             mode = Modes.Normal },
        { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Trouble Location List",        mode = Modes.Normal },
        { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Trouble Quickfix list",        mode = Modes.Normal }
    }
})
