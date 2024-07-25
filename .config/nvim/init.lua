-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.cmd([[
  command! Q lua require('neo-tree.command').execute({ action = 'close' }) vim.cmd('q')
]])

require 'setup'
-- [[ Setting options ]]
require 'opts'

-- [[ Basic Keymaps ]]
require 'keybinds'

