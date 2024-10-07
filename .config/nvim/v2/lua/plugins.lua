return {
    { lazy = true,        "nvim-lua/plenary.nvim" },
    {
        "nvchad/ui",
        config = function()
            require "nvchad"
        end
    },

    {
        "nvchad/base46",
        lazy = true,
        build = function()
            require("base46").load_all_highlights()
        end,
    },
    {
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VimEnter'
        config = function() -- This is the function that runs, AFTER loading
            require('which-key').setup(
                {
                    show_help = false,
                    preset = "helix",
                    delay = 0,
                    plugins = {
                        presets = {
                            motions = true,
                            operators = true,
                        }
                    },
                    win = {
                        title = false,
                        wo = { winblend = 0, },
                    },
                }
            )
            -- Document existing key chains
            require('which-key').add(
                {
                    { "<leader>c", group = "Code" },
                    { "<leader>c_", hidden = true },
                    { "<leader>d", group = "Document" },
                    { "<leader>d_", hidden = true },
                    { "<leader>r", group = "Rename" },
                    { "<leader>r_", hidden = true },
                    { "<leader>f", group = "Telescope" },
                    { "<leader>f_", hidden = true },
                    { "<leader>s", group = "Search" },
                    { "<leader>e", group = "Explorer", icon = { icon = "󰪶", color = "green" } },
                    { "<leader>e_", hidden = true },
                    { "<leader>s_", hidden = true },
                    { "<leader>t", group = "Terminal" },
                    { "<leader>t_", hidden = true },
                    { "<leader>w", group = "Workspace" },
                    { "<leader>w_", hidden = true },
                    { "<leader>x", group = "Trouble", icon = { icon = " ", color = "orange" } },
                    { "<leader>x_", hidden = true },
                })
        end,
    },
    {
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
    },
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '│' },
        topdelete = { text = '│' },
        changedelete = { text = '│' },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
    { require 'lsp' },
    { require 'cmp' },
    { require 'telescope' },
}
