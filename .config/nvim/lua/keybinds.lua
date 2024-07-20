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
---@param mode string
---@param bind string
---@param cmd string | function
---@param opts table
local nmap = function(mode, bind, cmd, opts)
    vim.keymap.set(mode, bind, cmd, opts)
end
-- {{{ LSP 
if config.Options.enable_lsp then
nmap(Modes.Normal, '<leader>q', function()
    vim.lsp.buf.format()
end, { desc = '[Q] Format File'})
end
-- }}}
-- Telescope --
if config.Plugins.telescope_enabled == true then
    nmap(Modes.Normal, '<leader><leader>', '<CMD>Telescope find_files<CR>', { desc = '[ ] Find Files' })
    nmap(Modes.Normal, '<leader>ff', '<CMD>Telescope find_files<CR>', { desc = '[F]ind [F]iles' })
    nmap(Modes.Normal, '<leader>ds', '<CMD>Telescope lsp_document_symbols<CR>', { desc = '[D]ocument [S]ymbols' })
end
nmap(Modes.Normal, '<leader>dw', '<CMD>w<CR>', { desc = '[D]ocument [W]rite' })
nmap(Modes.Normal, '<leader>dc', '<CMD>bdelete<CR>', { desc = '[D]ocument [C]lose' })
-- Window management --
nmap(Modes.Normal, '<C-Left>', '<CMD>wincmd h<CR>', { desc = 'Move to [H] window' })
nmap(Modes.Normal, '<C-Down>', '<CMD>wincmd j<CR>', { desc = 'Move to [J] window' })
nmap(Modes.Normal, '<C-Right>', '<CMD>wincmd l<CR>', { desc = 'Move to [L] window' })
nmap(Modes.Normal, '<C-Up>', '<CMD>wincmd k<CR>', { desc = 'Move to [K] window' })
if config.Options.tmux_integration then
    nmap(Modes.Normal, '<C-h>', '<CMD>TmuxNavigateLeft<CR>', {desc = "[T] Window left"})
    nmap(Modes.Normal, '<C-j>', '<CMD>TmuxNavigateDown<CR>', {desc = "[T] Window down"})
    nmap(Modes.Normal, '<C-k>', '<CMD>TmuxNavigateUp<CR>', {desc = "[T] Window up"})
    nmap(Modes.Normal, '<C-l>', '<CMD>TmuxNavigateRight<CR>', {desc = "[T] Window right"})
end
nmap(Modes.Normal, '<leader>sh', '<CMD>split<CR>', {desc = '[S]plit [H]orizontal'})
nmap(Modes.Normal, '<leader>sv', '<CMD>vs<CR>', {desc = '[S]plit [V]ertical'})
-- Terminal --
if config.Plugins.toggleterm_enabled == true then
    nmap(Modes.Normal, "<leader>tf", '<CMD>ToggleTerm direction=float<CR>', { desc = '[T]erminal [F]loat' })
    nmap(Modes.Normal, '<leader>th', '<CMD>ToggleTerm direction=horizontal<CR>', { desc = '[T]erminal [H]orizontal' })
    nmap(Modes.Normal, '<leader>tv', '<CMD>ToggleTerm direction=vertical<CR>', { desc = '[T]erminal [V]ertical' })
    nmap(Modes.Normal, '<leader>td', '<CMD>ToggleTerm direction=horizontal size=10<CR>', { desc = '[T]erminal [D]ebug' })
end
-- File tree --
if config.Plugins.explorer == 'neo-tree' then
    nmap(Modes.Normal, '<leader>ee', '<CMD>Neotree toggle<CR>', { desc = '[E]xplorer'})
    nmap(Modes.Normal, '<leader>er', '<CMD>Neotree float right<CR>', { desc = '[E]xplorer [R]ight'})
    nmap(Modes.Normal, '<leader>el', '<CMD>Neotree float left<CR>', { desc = '[E]xplorer [L]eft'})
    nmap(Modes.Normal, '<leader>ec', '<CMD>Neotree float center<CR>', { desc = '[E]xplorer [C]enter'})
end
-- Buffer lines --
if config.Plugins.bufferline == 'barbar' then
    nmap(Modes.Normal, "<Tab>", "<CMD>BufferNext<CR>", { desc = "[Tab] Next Buffer" })
    nmap(Modes.Normal, "<S-Tab>", "<CMD>BufferPrev<CR>", { desc = "[S-Tab] Previous Buffer" })
elseif config.Plugins.bufferline == "nvim-bufferline" then
    nmap(Modes.Normal, "<Tab>", "<CMD>BufferLineCycleNext<CR>", { desc = "[Tab] Next Buffer"})
    nmap(Modes.Normal, "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>", { desc = "[S-Tab] Previous Buffer"})
end
