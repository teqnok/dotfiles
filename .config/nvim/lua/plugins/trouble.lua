return {
  'folke/trouble.nvim',
  cmd = 'TroubleToggle',
  config = function()
    require('trouble').setup {
      auto_preview = false,
      auto_fold = true,
      use_lsp_diagnostic_signs = true,
    }
  end,
}