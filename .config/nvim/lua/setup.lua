local builtins = {"2html_plugin", "getscript", "getscriptPlugin", "gzip"}
for i, _ in ipairs(builtins) do
    vim.g['loaded_' .. builtins[i]]= true
end
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Vim options -- 
require 'lazy'.setup({
  spec = {
    import = "plugins"
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
})

