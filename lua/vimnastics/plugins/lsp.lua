return {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
        { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        {
            'j-hui/fidget.nvim',
            opts = {
                notification = {
                    override_vim_notify = true,
                },
            },
        },
        { 'folke/neodev.nvim', opts = {} },
        require 'vimnastics.plugins.lsp_signature',
        require 'vimnastics.plugins.lspsaga',
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('vimnastics-lsp-attach', { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if not client then
                    return
                end
                if client.name == 'copilot' then
                    return
                end

                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                -- map('gR', vim.lsp.buf.rename, 'variable rename')
                -- map('gi', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
                -- map('gD', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
                -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                map('<leader>dws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                -- map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                -- map('K', vim.lsp.buf.hover, 'Hover Documentation')
                -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                if client.server_capabilities.documentHighlightProvider then
                    local highlight_augroup = vim.api.nvim_create_augroup('vimnastics-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })
                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('vimnastics-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'vimnastics-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end
                if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                    map('<leader>tih', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
                    end, '[T]oggle Inlay [H]ints')
                end

                if client.name == 'jdtls' then
                    -- Telescope bug
                    map('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', '[G]oto [D]efinition')
                end
            end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace',
                        },
                        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                        -- diagnostics = { disable = { 'missing-fields' } },
                    },
                },
            },
            pyright = {
                -- cmd = {...},
                -- filetypes = { ...},
                -- capabilities = {},
                settings = {
                    python = {
                        analysis = {
                            -- autoSearchPaths = true,
                            diagnosticMode = 'openFilesOnly',
                            typeCheckingMode = 'standard',
                            diagnosticSeverityOverrides = {
                                reportMissingImports = 'error',
                                reportUnknownVariableType = 'none', -- there are too much usage of Union in python
                                reportUnusedImport = 'error',
                                reportUnusedClass = 'error',
                                reportUnusedFunction = 'error',
                                reportUnusedVariable = 'error',
                                reportDuplicateImport = 'error',
                                reportWildcardImportFromLibrary = 'error',
                                reportUndefinedVariable = 'error',
                            },
                        },
                    },
                },
            },
        }

        require('mason').setup()

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua',
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for tsserver)
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        }
    end,
}
