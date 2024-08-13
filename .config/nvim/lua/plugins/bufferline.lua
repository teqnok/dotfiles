-- VSCode-style tab bar


local opts = require('config')
if opts.Plugins.bufferline == "buffertabs" then
    return {
        'tomiis4/BufferTabs.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        lazy = false,
        config = function()
            require('buffertabs').setup({
                -- config
            })
        end
    }
elseif opts.Plugins.bufferline == "nvim-bufferline" then
    return {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Explorer",
            highlight = "Directory",
            text_align = "center",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
    }
elseif opts.Plugins.bufferline == "barbar.nvim" then
    return {
        'romgrk/barbar.nvim',
        config = function()
            require('bufferline').setup {}
        end
    }
else
    return {}
end
