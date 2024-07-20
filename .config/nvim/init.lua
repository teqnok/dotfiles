-- Lazy.nvim setup-- 
local config = require 'config'
local global = vim.g
global.mapleader = config.Options.leader
global.maplocalleader = "\\"
require 'setup'
-- Keybindings -- 
require 'keybinds'
-- Vim options -- 
require 'opts'