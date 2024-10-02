-- Dashboard when starting nvim without any arguments
local config = require 'config'
if config.Plugins.dashboard == "alpha" then
  return {
    'goolord/alpha-nvim',
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'
      dashboard.section.header.val = {
        [[                                   ]],
        [[                      ( )          ]],
        [[ _ __   ___  _____   ___ _ __ ___  ]],
        [[| '_ \ / _ \/ _ \ \ / / | '_ ` _ \ ]],
        [[| | | |  __/ (_) \ V /| | | | | | |]],
        [[|_| |_|\___|\___/ \_/ |_|_| |_| |_|]],
        [[                                   ]],
        [[          version 0.10.0           ]],
      }
      dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('f', '  Find file', ':Telescope find_files<CR>'),
        dashboard.button('t', '󰺮  Find text', ':Telescope live_grep<CR>'),
        dashboard.button('u', '  Update plugins', ':Lazy update<CR>'),
        dashboard.button('r', '  Recent', ':Telescope oldfiles<CR>'),
        dashboard.button('s', '  Settings', ':e $MYVIMRC | :cd %:p:h<CR>'),
        dashboard.button('q', '󰅚  Quit NVIM', ':qa<CR>'),
      }

      dashboard.config.opts.noautocmd = true

      alpha.setup(dashboard.config)
    end,
  }
else return {}
end
if Config.Plugins.dashboard == "dashboard-nvim" then
  return {
    'glepnir/dashboard-nvim',
    config = function()
      require('dashboard').setup()
    end
  }
else return {}
end
