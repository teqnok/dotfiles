-- User-space configuration
local Config = {}

Config.Options = {
    ---Relative line numbers (asc/descending from cursor)
    --- recommended: true
    relativenumber = true,
    ---Line numbers
    --- recommended: true
    number = true,
    ---Enable tmux integration keybinds (along with <C-h/j/k/l> for split navigation)
    --- recommended: false
    tmux_integration = true,
    ---Leader keybind
    --- recommended: ' ' (Space)
    leader = ' ',
    ---Enable default LSP plugins 
    --- recommended: true
    enable_lsp = true,
    --- LSP indicator messages
    fidget = true,
    ---Colorscheme (nullable)
    --- recommended: Catppuccin Macchiato
    colorscheme = 'catppuccin'
}
Config.Plugins = {
    --- Allowed values: 'nvim-cmp' | 'coq_nvim'
    ---  recommended: 'nvim-cmp'
    completion = "nvim-cmp",
    --- Allowed values: 'alpha' | 'dashboard-nvim'
    ---  recommended: 'alpha'
    dashboard = "alpha",
    --- Allowed values: 'neo-tree' | 'nvim-tree'
    ---  recommended: 'neo-tree'
    explorer = "neo-tree",
    --- Allowed values: 'lualine' | 'sttusline'
    ---  recommended: 'lualine'
    statusline = 'lualine',
    --- Allowed values: 'copilot' | 'codeium'
    ---  recommended: 'copilot'
    ---  NOTE: Copilot requires a paid subscription
    copilot = 'copilot',
    --- Allowed values: 'nvim-bufferline' | 'buffertabs' | 'barbar'
    ---  recommended: 'nvim-bufferline'
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
