-- Autocompletion Engine
local Config = require 'config'

LspKind = {}

LspKind.Symbol = {
  File = { text = "File", icon = "" },
  Module = { text = "Module", icon = "" },
  Namespace = { text = "Namespace", icon = "" },
  Package = { text = "Package", icon = "" },
  Class = { text = "Class", icon = "" },
  Method = { text = "Method", icon = "" },
  Property = { text = "Property", icon = "" },
  Field = { text = "Field", icon = "" },
  Constructor = { text = "Constructor", icon = "" },
  Enum = { text = "Enum", icon = "" },
  Interface = { text = "Interface", icon = "" },
  Function = { text = "Function", icon = "" },
  Variable = { text = "Variable", icon = "" },
  Constant = { text = "Constant", icon = "" },
  String = { text = "String", icon = "ﱕ" },
  Number = { text = "Number", icon = "" },
  Boolean = { text = "Boolean", icon = "" },
  Array = { text = "Array", icon = "" },
  Object = { text = "Object", icon = "" },
  Key = { text = "Key", icon = "" },
  Null = { text = "Null", icon = "" },
  EnumMember = { text = "EnumMember", icon = "" },
  Struct = { text = "Struct", icon = "" },
  Event = { text = "Event", icon = "ﯓ" },
  Operator = { text = "Operator", icon = "" },
  TypeParameter = { text = "TypeParameter", icon = "" },
}

LspKind.Completion = {
  Text = { text = "Text", icon = "" },
  Method = { text = "Method", icon = "" },
  Function = { text = "Function", icon = "" },
  Constructor = { text = "Constructor", icon = "" },
  Field = { text = "Field", icon = "" },
  Variable = { text = "Variable", icon = "" },
  Class = { text = "Class", icon = "" },
  Interface = { text = "Interface", icon = "" },
  Module = { text = "Module", icon = "" },
  Property = { text = "Property", icon = "" },
  Unit = { text = "Unit", icon = "ﱦ" },
  Value = { text = "Value", icon = "" },
  Enum = { text = "Enum", icon = "" },
  Keyword = { text = "Keyword", icon = "" },
  Snippet = { text = "Snippet", icon = "" },
  Color = { text = "Color", icon = "" },
  File = { text = "File", icon = "" },
  Reference = { text = "Reference", icon = "" },
  Folder = { text = "Folder", icon = "" },
  EnumMember = { text = "EnumMember", icon = "" },
  Constant = { text = "Constant", icon = "" },
  Struct = { text = "Struct", icon = "" },
  Event = { text = "Event", icon = "ﯓ" },
  Operator = { text = "Operator", icon = "" },
  TypeParameter = { text = "TypeParameter", icon = "" },
}
if Config.Plugins.completion == "nvim-cmp" then
  return {

    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    priority = 1000,
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      cmp.setup({
        window = {
          documentation = { max_height = 15 },
          completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = 1,
            side_padding = 0,
          },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-.>'] = cmp.mapping.select_next_item(),
          ['<C-,>'] = cmp.mapping.select_prev_item(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "<" .. (strings[2] or "") .. ">"

            return kind
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },   -- For vsnip users.
          { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        })
      })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#5b6078", fg = "#cad3f5" })
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#363a4f", fg = "#cad3f5" })

      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#939ab7", bg = "NONE", strikethrough = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#8aadf4", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#8aadf4", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#f5bde6", bg = "NONE", italic = true })
    end,
  }
elseif Config.Plugins.cmp == "coq_nvim" then
  return {
    {
      'ms-jpq/coq_nvim',
      branch = 'coq',
      run = ':COQdeps',
      requires = {
        { 'ms-jpq/coq.artifacts',  branch = 'artifacts' },
        { 'ms-jpq/coq.thirdparty', branch = '3p' },
      },
      config = function()
        require('coq') {
          display = {
            ghost_text = {
              enabled = true,
              context = { 'Snippet', 'Inline', 'Paren' },
            },
            pum = {
              fast_close = true,
              source_context = { 'Snippet', 'Inline', 'Paren' },
            },
          },
        }
      end,
    },
  }
else
  return {}
end

-- vim: ts=2 sts=2 sw=2 et
