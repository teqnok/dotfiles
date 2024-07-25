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
    ---Enable default LSP plugins 
    --- Default: true
    enable_lsp = true,
    --- LSP indicator messages
    fidget = true,
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
    ---  Default: 'neo-tree'
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

    autopairs_enabled = true,
    --- Breadcrumbs (eg config.lua > Config.Plugins)
    dropbar_enabled = true,
    --- Better integrated terminal
    toggleterm_enabled = true,
    --- Git integration for the buffer's sidebar 
    gitsigns_enabled = true,
    --- Language parsing 
    treesitter_enabled = true,
    --- Finder for pretty much everything 
    telescope_enabled = true,

    inlayhints_enabled = true,
    --- Show errors on line hover
    inline_diagnostics = true,
    --- Better markdown rendering 
    markdown_enabled = true,
    --- LSP diagnostic viewer
    trouble_enabled = true,

}

return Config
