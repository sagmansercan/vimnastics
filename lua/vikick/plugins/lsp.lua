return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        { 'j-hui/fidget.nvim', opts = {} },
        { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('vikick-lsp-attach', { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if not client then return end
                if client.name == 'copilot' then return end

                local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc }) end

                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                map('K', vim.lsp.buf.hover, 'Hover Documentation')
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                if client.server_capabilities.documentHighlightProvider then
                    local highlight_augroup = vim.api.nvim_create_augroup('vikick-lsp-highlight', { clear = false })
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
                        group = vim.api.nvim_create_augroup('vikick-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'vikick-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end
                if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                    map('<leader>tih', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {}) end, '[T]oggle Inlay [H]ints')
                end

                if client.name == 'jdtls' then
                    -- Telescope bug
                    map('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', '[G]oto [D]efinition')
                end
            end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        local servers = {
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            -- rust_analyzer = {},
            -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
            --
            -- Some languages (like typescript) have entire language plugins that can be useful:
            --    https://github.com/pmizio/typescript-tools.nvim
            --
            -- But for many setups, the LSP (`tsserver`) will work just fine
            -- tsserver = {},
            --

            lua_ls = {
                -- cmd = {...},
                -- filetypes = { ...},
                -- capabilities = {},
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
            pyright = { -- https://github.com/microsoft/pyright
                -- cmd = {...},
                -- filetypes = { ...},
                -- capabilities = {},
                settings = {
                    python = {
                        analysis = {
                            -- autoSearchPaths = true,
                            diagnosticMode = 'openFilesOnly',
                            -- typeCheckingMode = 'off', -- this is very annoying when using Optional arguments in functions. Who cares the types in python anyway :P
                            typeCheckingMode = 'strict',
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
            -- [[
            -- jdtls is disables in favor of mfussenegger/nvim-jdtls plugin for better integration
            --
            -- jdtls = {
            --     -- cmd = {...},
            --     -- filetypes = { ...},
            --     -- capabilities = {},
            --     -- settings = {
            --     --     java = {
            --     --         signatureHelp = {
            --     --             enabled = true,
            --     --         },
            --     --         completion = {
            --     --             favoriteStaticMembers = {
            --     --                 'org.hamcrest.MatcherAssert.assertThat',
            --     --                 'org.hamcrest.Matchers.*',
            --     --                 'org.junit.jupiter.api.Assertions.*',
            --     --                 'org.junit.jupiter.api.Assumptions.*',
            --     --                 'org.junit.jupiter.api.DynamicContainer.dynamicContainer',
            --     --                 'org.junit.jupiter.api.DynamicTest.dynamicTest',
            --     --                 'org.junit.jupiter.api.TestFactory',
            --     --                 'org.junit.jupiter.api.TestTemplate',
            --     --                 'org.mockito.Mockito.*',
            --     --             },
            --     --         },
            --     --         sources = {
            --     --             organizeImports = {
            --     --                 starThreshold = 9999,
            --     --                 staticStarThreshold = 9999,
            --     --             },
            --     --         },
            --     --         codeGeneration = {
            --     --             toString = {
            --     --                 template = 'ToStringBuilder.reflectionToString(this, org.apache.commons.lang3.builder.ToStringStyle.MULTI_LINE_STYLE)',
            --     --                 style = 'apache',
            --     --             },
            --     --         },
            --     --         configuration = {
            --     --             runtimes = {
            --     --                 {
            --     --                     name = 'JavaSE-11',
            --     --                     path = '/usr/lib/jvm/java-11-openjdk',
            --     --                 },
            --     --             },
            --     --         },
            --     --     },
            --     -- },
            -- },
            -- ]]
        }

        require('mason').setup()

        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'stylua', -- Used to format Lua code
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
