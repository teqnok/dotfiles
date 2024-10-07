local config = require "config"

if config.Options.tmux_integration then
    return {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    }
else
    return {}
end
