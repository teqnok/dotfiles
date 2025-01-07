-- [[ Setting options ]]

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
vim.opt.relativenumber = true
-- max number of items in the LSP completion menu
vim.opt.pumheight = 10
-- Enable mouse mode
vim.opt.mouse = 'a'
-- Hide the command line's row when not in use
vim.opt.cmdheight = 0
-- Don't show the mode, since it's already in status line
vim.opt.showmode = false
-- Use the default system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 100

vim.g.netrw_banner = 0
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- Set tab width to 4 instead of 8
vim.opt.tabstop = 4
-- Set each indentation level to also use 4
vim.opt.shiftwidth = 4
-- And convert tabs to spaces
vim.opt.expandtab = true
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.softtabstop = 2
        vim.bo.expandtab = true
    end,
})
vim.opt.inccommand = 'split'
-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Disable builtin virtual text 
vim.diagnostic.config({virtual_text = false})
-- vim.lsp.inlay_hint.enable(true)

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
