local keybinds = {}

local Modes = {
    Visual   = 'v',
    Normal   = 'n',
    Command  = 'c',
    Terminal = 't',
    Select   = 's',
    Insert   = 'i',
    Replace  = 'r',
}

keybinds.__pre =
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
}
keybinds.main = {
    { "<leader>n",   "<CMD>nohlsearch<CR>",                                        desc = "Stop search",                  mode = Modes.Normal },
    { "<leader>L",   "<CMD>Lazy<CR>",                                              desc = "Lazy",                         mode = Modes.Normal },
    { "d",           '"ad',                                                        desc = 'Delete to "a',                 mode = { Modes.Normal, Modes.Visual }, noremap = true },
    { "<leader>S",   "ggVG",                                                       desc = 'Select All',                   mode = { Modes.Normal, Modes.Visual }, noremap = true },
    { "<leader>p",   '"ap',                                                        desc = "Paste from deletion buffer",   mode = { Modes.Normal, Modes.Visual }, noremap = true },
    -- { ";",         "<CMD>Telescope cmdline<CR>", desc = "Cmdline",                    mode = { Modes.Normal },               noremap = true },
    { "<leader>q",   function() vim.lsp.buf.format() end,                          desc = "Format",                       mode = Modes.Normal },
    { "<leader>a",   function() vim.lsp.buf.code_action() end,                     desc = " Code Action",                 mode = Modes.Normal,                   noremap = true, silent = true },
    { "<leader><leader>",   "<CMD>Telescope find_files<CR>",                              desc = "Find Files",                   mode = {Modes.Visual, Modes.Normal} },
    { "<leader>F",   "<CMD>Telescope find_files<CR>",                              desc = "Find Files",                   mode = Modes.Normal },
    { "<leader>ff",  "<CMD>Telescope find_files<CR>",                              desc = "Find Files",                   mode = Modes.Normal },
    { "<leader>K",   "<CMD>Telescope keymaps<CR>",                              desc = "Keymaps",                   mode = Modes.Normal },
    { "<leader>fg",  "<CMD>Telescope live_grep<CR>",                               desc = "Find with Grep",               mode = Modes.Normal },
    { "<leader>ds",  "<CMD>Telescope lsp_document_symbols<CR>",                    desc = " Document Symbols",            mode = Modes.Normal },
    { "<leader>dw",  "<CMD>w<CR>",                                                 desc = " Document Write",              mode = Modes.Normal },
    { "<leader>dc",  "<CMD>bp|bd#<CR>",                                            desc = " Document Close",              mode = Modes.Normal },

    -- Window management
    { "<C-Left>",    "<CMD>wincmd h<CR>",                                          desc = " Move to left window",         mode = Modes.Normal },
    { "<C-Down>",    "<CMD>wincmd j<CR>",                                          desc = " Move to down window",         mode = Modes.Normal },
    { "<C-Right>",   "<CMD>wincmd l<CR>",                                          desc = " Move to right window",        mode = Modes.Normal },
    { "<C-Up>",      "<CMD>wincmd k<CR>",                                          desc = " Move to up window",           mode = Modes.Normal },
    { "<C-S-Left>",  "<CMD>vertical resize -2<CR>",                                desc = "Resize window left",           mode = Modes.Normal },
    { "<C-S-Right>", "<CMD>vertical resize +2<CR>",                                desc = "Resize window right",          mode = Modes.Normal },
    { "<C-S-Up>",    "<CMD>resize +2<CR>",                                         desc = "Resize window up",             mode = Modes.Normal },
    { "<C-S-Down>",  "<CMD>resize -2<CR>",                                         desc = "Resize window down",           mode = Modes.Normal },

    { "<leader>sh",  "<CMD>split<CR>",                                             desc = " Split Horizontal",            mode = Modes.Normal },
    { "<leader>sv",  "<CMD>vs<CR>",                                                desc = " Split Vertical",              mode = Modes.Normal },

    -- Terminal

    { "<leader>T",   "<CMD>ToggleTerm direction=horizontal<CR>",                   desc = "Terminal",                     mode = Modes.Normal },
    { "<leader>tf",  "<CMD>ToggleTerm direction=float<CR>",                        desc = "Float (center)",               mode = Modes.Normal },
    { "<leader>th",  "<CMD>ToggleTerm direction=horizontal<CR>",                   desc = "Bottom",                       mode = Modes.Normal },
    { "<leader>tv",  "<CMD>ToggleTerm direction=vertical<CR>",                     desc = "Sidebar",                      mode = Modes.Normal },


    { "<leader>E",   "<CMD>Neotree toggle<CR>",                                    desc = "Explorer",                     mode = Modes.Normal },
    { "<leader>er",  "<CMD>Neotree float right<CR>",                               desc = "Explorer Right",               mode = Modes.Normal },
    { "<leader>el",  "<CMD>Neotree float left<CR>",                                desc = "Explorer Left",                mode = Modes.Normal },
    { "<leader>ec",  "<CMD>Neotree float center<CR>",                              desc = "Explorer Center",              mode = Modes.Normal },

    -- Buffer lines
    { "<Tab>",       "<CMD>BufferLineCycleNext<CR>",                               desc = "Next Buffer",                  mode = Modes.Normal },
    { "<S-Tab>",     "<CMD>BufferLineCyclePrev<CR>",                               desc = "Previous Buffer",              mode = Modes.Normal },


    -- Trouble (Errors)
    { "<leader>xd",  "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Trouble diagnostics (Global)", mode = Modes.Normal },
    { "<leader>xD",  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Trouble Diagnostics (Buffer)", mode = Modes.Normal },
    { "<leader>xs",  "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Trouble Symbols",              mode = Modes.Normal },
    { "<leader>xl",  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Trouble LSP Info",             mode = Modes.Normal },
    { "<leader>xL",  "<cmd>Trouble loclist toggle<cr>",                            desc = "Trouble Location List",        mode = Modes.Normal },
    { "<leader>xQ",  "<cmd>Trouble qflist toggle<cr>",                             desc = "Trouble Quickfix list",        mode = Modes.Normal }
}
return keybinds
