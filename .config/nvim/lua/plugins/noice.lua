return -- lazy.nvim
{
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
  },
  config = function()
    require('noice').setup {
      presets = {
        command_palette = true,
        lsp_doc_border = true,
      },
      -- messages = {
      --   enabled = true,
      --   view = 'notify',
      -- },
      -- notify = {
      --   enabled = true,
      --   view = 'notify',
      -- },
    }
  end,
}
