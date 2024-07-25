local config = require 'config'
if config.Options.enable_lsp == false then
    return {}
else
    return {
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                'williamboman/mason.nvim',
                'williamboman/mason-lspconfig.nvim',
                'WhoIsSethDaniel/mason-tool-installer.nvim',
                'hrsh7th/cmp-nvim-lsp',
                { 'folke/neodev.nvim', opts = {} },
            },
            config = function()
                vim.api.nvim_create_autocmd('LspAttach', {
                    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                    callback = function(event)
                        local map = function(keys, func, desc)
                            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                        end

                        -- Jump to the definition of the word under your cursor.
                        --  This is where a variable was first declared, or where a function is defined, etc.
                        --  To jump back, press <C-t>.
                        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                        -- Find references for the word under your cursor.
                        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                        -- Jump to the implementation of the word under your cursor.
                        --  Useful when your language has ways of declaring types without an actual implementation.
                        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                        -- Jump to the type of the word under your cursor.
                        --  Useful when you're not sure what type a variable is and you want to see
                        --  the definition of its *type*, not where it was *defined*.
                        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

                        -- Fuzzy find all the symbols in your current document.
                        --  Symbols are things like variables, functions, types, etc.
                        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

                        -- Fuzzy find all the symbols in your current workspace
                        --  Similar to document symbols, except searches over your whole project.
                        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
                            '[W]orkspace [S]ymbols')


                        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

                        map('K', vim.lsp.buf.hover, 'Hover Documentation')


                        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')


                        local client = vim.lsp.get_client_by_id(event.data.client_id)
                        if client and client.server_capabilities.documentHighlightProvider then
                            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                                buffer = event.buf,
                                callback = vim.lsp.buf.document_highlight,
                            })

                            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                                buffer = event.buf,
                                callback = vim.lsp.buf.clear_references,
                            })
                        end
                    end,
                })


                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())


                local servers = {
                    clangd = {},
                    gopls = {},
                    pyright = {},
                    rust_analyzer = {},

                    lua_ls = {
                        settings = {
                            Lua = {
                                completion = {
                                    callSnippet = 'Replace',
                                },
                                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                                diagnostics = { disable = { 'missing-fields' } },
                            },
                        },
                    },
                }

                require('mason').setup()

                require('mason-lspconfig').setup {
                    handlers = {
                        function(server_name)
                            local server = servers[server_name] or {}
                            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities,
                                server.capabilities or {})
                            require('lspconfig')[server_name].setup(server)
                        end,
                    },
                }
            end,
        },
    }
end
