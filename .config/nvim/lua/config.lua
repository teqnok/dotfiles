-- User-space configuration
local Config = {}

Config.Options = {
    ---Relative line numbers (asc/descending from cursor)
    --- Default: true
    relativenumber = true,
    ---Line numbers
    --- Default: true
    number = true,
    ---Enable tmux integration keybinds
    --- Default: false
    tmux_integration = true,
    ---Leader keybind
    --- Default: ' ' (Space)
    leader = ' ',
    enable_lsp = true,
    ---Colorscheme (nullable)
    --- Default: Catppuccin Macchiato
    colorscheme = 'catppuccin'
}
Config.Plugins = {
    --- Allowed values: 'nvim-cmp' | 'coq_nvim'
    ---  Default: 'nvim-cmp'
    completion = "nvim-cmp",
    --- Allowed values: 'alpha' | 'dashboard-nvim'
    ---  Default: 'alpha'
    dashboard = "alpha",
    --- Allowed values: 'neo-tree' | 'nvim-tree'
    ---  Default: 'neotree'
    explorer = "neo-tree",
    --- Allowed values: 'lualine' | 'sttusline'
    ---  Default: 'lualine'
    statusline = 'lualine',
    --- Allowed values: 'copilot' | 'codeium'
    ---  Default: 'copilot'
    ---  NOTE: Copilot requires a paid subscription
    copilot = 'copilot',
    --- Allowed values: 'nvim-bufferline' | 'buffertabs' | 'barbar'
    ---  Default: 'nvim-bufferline'
    bufferline = 'nvim-bufferline',
    --- Allowed values: true | false
    ---  Default: true
    autopairs_enabled = true,
    --- Allowed values: true | false
    ---  Default: true
    dropbar_enabled = true,
    --- Allowed values: true | false
    ---  Default: true
    toggleterm_enabled = true,
    --- Allowed values: true | false
    --- Default: true
    gitsigns_enabled = true,
    --- Allowed values: true | false
    --- Default: true
    treesitter_enabled = true,
    --- Allowed values: true | false
    --- Default: true
    telescope_enabled = true,
    --- Allowed values: true | false
    --- Default: true
    inlayhints_enabled = true,
}

return Config
