local config = require 'config'
if config.Plugins.toggleterm_enabled == true then
    return { 'akinsho/toggleterm.nvim', version = "*", config = true }
else
    return {}
end
