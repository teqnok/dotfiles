-- Breadcrumbs (fn main -> impl Package -> fn install())
local config = require 'config'
if config.Plugins.dropbar_enabled == true then
    return {
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim'
        }
    }
else
    return {}
end
