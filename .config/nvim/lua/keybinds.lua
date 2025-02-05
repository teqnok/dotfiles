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

keybinds.__pre = {
    { "<leader>d", group = "Document", icon = { icon = "󰈙", color = "blue" } },
    { "<leader>d_", hidden = true },
    { "<leader>f", group = "Fzf", icon = { icon = "", color = "blue" } },
    { "<leader>f_", hidden = true },
    { "<leader>s", group = "Split", icon = { icon = "󰯌", color = "blue" } },
    { "<leader>s_", hidden = true },
    { "<leader>g", group = "Git" },
    { "<leader>g_", hidden = true },
    { "<leader>t", group = "Terminal" },
    { "<leader>t_", hidden = true },
    { "<leader>w", group = "Workspace" },
    { "<leader>w_", hidden = true },
    { "<leader>x", group = "Trouble", icon = { icon = " ", color = "orange" } },
    { "<leader>x_", hidden = true },
}
local fzf = require('fzf-lua')
keybinds.main = {
    { "H", function() vim.diagnostic.open_float() end, { noremap = true, silent = true }, mode = Modes.Normal },
    { "<leader>n", "<CMD>nohlsearch<CR>", desc = "Stop search", mode = Modes.Normal },
    { "<leader>L", "<CMD>Lazy<CR>", desc = "Lazy", mode = Modes.Normal, icon = { icon = "󰏖" } },
    { "<leader>|", "<CMD>set number! | set relativenumber!<CR>", desc = "Toggle Line Numbers", mode = Modes.Normal, icon = { icon = "󰉻" } },
    { "<leader>t[", "<CMD>vsp | terminal<CR>A", desc = "New Terminal [Vertical]", mode = Modes.Normal },
    { "<leader>t]", "<CMD>sp | terminal<CR>A", desc = "New Terminal", mode = Modes.Normal },
    { "d", '"ad', desc = 'Delete to "a', mode = { Modes.Normal, Modes.Visual }, noremap = true },
    { "<leader>S", "ggVG", desc = 'Select All', mode = { Modes.Normal, Modes.Visual }, noremap = true, icon = { icon = "󰩬" } },
    { "<leader>p", '"ap', desc = "Paste from deletion buffer", mode = { Modes.Normal, Modes.Visual }, noremap = true },
    { "<leader>q", function() vim.lsp.buf.format() end, desc = "Format", mode = Modes.Normal },
    { "<leader>R", function() vim.lsp.buf.rename() end, desc = "Rename [LSP]", mode = Modes.Normal, noremap = true, silent = true, icon = { icon = "󰘎" } },
    { "<leader>a", function() fzf.lsp_code_actions() end, desc = " Code Action", mode = Modes.Normal, noremap = true, silent = true },
    { "<leader><leader>", function() Snacks.picker.files() end, desc = "Find Files", mode = { Modes.Visual, Modes.Normal } },
    { "<leader>h", function() Snacks.picker.buffers() end, desc = "Find Buffers", mode = { Modes.Visual, Modes.Normal } },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files", mode = Modes.Normal },
    { "<leader>fl", function() Snacks.picker.lines() end, desc = "Find Lines", mode = Modes.Normal },
    { "<leader>ft", function() Snacks.picker.diagnostics() end, desc = "Find Trouble", mode = Modes.Normal },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Find with Grep", mode = Modes.Normal },
    { "<leader>ds", function() Snacks.picker.lsp_symbols() end, desc = " Document Symbols", mode = Modes.Normal },
    { "<leader>gf", function() Snacks.picker.git_files() end, desc = "Git Files", mode = Modes.Normal },
    { "<leader>gS", function() Snacks.picker.git_stash({ prompt = "Git Stash >" }) end, desc = "Git Stash", mode = Modes.Normal },
    { "<leader>gs", function() Snacks.picker.git_status({ prompt = "Git Status >" }) end, desc = "Git Status", mode = Modes.Normal },
    { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Commits", mode = Modes.Normal },
    { "<leader>dw", "<CMD>w<CR>", desc = " Document Write", mode = Modes.Normal },
    { "<leader>dc", "<CMD>bp|bd#<CR>", desc = " Document Close", mode = Modes.Normal },
    -- only for nvim >= 0.11.0 (nightly atm)
    { "<leader>z", function() vim.lsp.foldexpr() end, desc = "Toggle Fold [LSP]", mode = Modes.Normal },
    { "<leader>sp", function() Snacks.picker.files() end, desc = "Snacks Picker", mode = Modes.Normal },
    -- snacks
    { "<leader>si", function() if Snacks.indent.enabled then Snacks.indent.disable() else Snacks.indent.enable() end end, desc = "Toggle indent guides", mode = Modes.Normal },
    --
    -- Window management
    { "<C-S-Left>", "<CMD>vertical resize -2<CR>", desc = "Resize window left", mode = Modes.Normal },
    { "<C-S-Right>", "<CMD>vertical resize +2<CR>", desc = "Resize window right", mode = Modes.Normal },
    { "<C-S-Up>", "<CMD>resize +2<CR>", desc = "Resize window up", mode = Modes.Normal },
    { "<C-S-Down>", "<CMD>resize -2<CR>", desc = "Resize window down", mode = Modes.Normal },
    { "<leader>sh", "<CMD>split<CR>", desc = " Split Horizontal", mode = Modes.Normal },
    { "<leader>sv", "<CMD>vs<CR>", desc = " Split Vertical", mode = Modes.Normal },
    { "<leader>se", "<CMD>vsp | Oil<CR>", desc = "Explorer (Split)", mode = Modes.Normal },
    { "<leader>~", "<CMD>e $MYVIMRC | :cd %:p:h<CR>", desc = "Edit Vim Config", mode = Modes.Normal, icon = { icon = "" } },
    { "<leader>E", "<CMD>Oil<CR>", desc = "Explorer", mode = Modes.Normal, icon = { icon = "󰪶" } },
    { "<leader>`", "<CMD>vsp | Oil<CR>", desc = "Explorer (Split)", mode = Modes.Normal, icon = { icon = "󰪶" } },
    -- def not stolen X3
    { "J", ":m '>+1<CR>gv=gv", desc = "Move Line Down", mode = Modes.Visual },
    { "K", ":m '<-2<CR>gv=gv", desc = "Move Line Down", mode = Modes.Visual },
    -- Trouble (Errors)
    { "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble diagnostics (Global)", mode = Modes.Normal },
    { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Trouble Symbols", mode = Modes.Normal },
    { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Trouble LSP Info", mode = Modes.Normal },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble Location List", mode = Modes.Normal },
    { "<leader>xD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble Diagnostics (Buffer)", mode = Modes.Normal },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble Quickfix list", mode = Modes.Normal }
}
return keybinds
