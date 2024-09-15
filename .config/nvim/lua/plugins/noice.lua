return -- lazy.nvim
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        config = function()
            require('noice').setup {
                lsp = {
                    override = {      
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,},
                },
                presets = {
                    command_palette = false,
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
