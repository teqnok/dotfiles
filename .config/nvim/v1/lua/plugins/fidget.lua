local config = require 'config'

if config.Options.fidget then
    return {
        "j-hui/fidget.nvim",
        config = function()
            require 'fidget'.setup({
                progress = {
                    display = {
                        render_limit = 5,
                    },
                },
                notification = {
                    window = {
                        max_width = 40,
                    },
                },
            })
        end,
    }
else
    return {}
end
