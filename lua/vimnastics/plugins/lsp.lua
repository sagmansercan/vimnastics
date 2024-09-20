return {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
        -- -- require 'vimnastics.plugins.lsp_signature', -- TODO: evaluating
    },
    config = function()
        require('lspconfig').lua_ls.setup {
            -- on_init = function(client)
            --   local path = client.workspace_folders[1].name
            --   if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            --     return
            --   end
            --
            --   client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            --     runtime = {
            --       -- Tell the language server which version of Lua you're using
            --       -- (most likely LuaJIT in the case of Neovim)
            --       version = 'LuaJIT'
            --     },
            --     -- Make the server aware of Neovim runtime files
            --     workspace = {
            --       checkThirdParty = false,
            --       library = {
            --         vim.env.VIMRUNTIME
            --         -- Depending on the usage, you might want to add additional paths here.
            --         -- "${3rd}/luv/library"
            --         -- "${3rd}/busted/library",
            --       }
            --       -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            --       -- library = vim.api.nvim_get_runtime_file("", true)
            --     }
            --   })
            -- end,
            settings = {
                Lua = {
                    -- runtime = {
                    --     version = 'LuaJIT',
                    --     path = vim.split(package.path, ';'),
                    -- },
                    -- diagnostics = {
                    --     globals = { 'vim' },
                    -- },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = {
                            [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                            [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
                        },
                    },
                },
            },
        }

        require('lspconfig').pyright.setup {
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
                            reportArgumentType = 'warning',
                            -- reportMissingImports = 'error',
                            -- reportUnknownVariableType = 'none', -- there are too much usage of Union in python
                            -- reportUnusedImport = 'warning',
                            -- reportUnusedClass = 'warning',
                            -- reportUnusedFunction = 'warning',
                            -- reportUnusedVariable = 'warning',
                            -- reportDuplicateImport = 'warning',
                            -- reportWildcardImportFromLibrary = 'warning',
                            -- reportUndefinedVariable = 'error',
                        },
                    },
                },
            },
        }

        require('lspconfig').jdtls.setup {
            cmd = {
                'java',
                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.level=ALL',
                '-Xmx3G',
                '-javaagent:' .. vim.fn.expand '~/.local/share/java/lombok.jar',
                '--add-modules=ALL-SYSTEM',
                '--add-opens=java.base/java.lang=ALL-UNNAMED',
                '--add-opens=java.base/java.lang.invoke=ALL-UNNAMED',
                '--add-opens=java.base/java.lang.reflect=ALL-UNNAMED',
                '--add-opens=java.base/java.io=ALL-UNNAMED',
                '--add-opens=java.base/java.net=ALL-UNNAMED',
                '--add-opens=java.base/java.nio=ALL-UNNAMED',
                '--add-opens=java.base/java.util=ALL-UNNAMED',
                '--add-opens=java.base/java.util.concurrent=ALL-UNNAMED',
                '--add-opens=java.base/java.util.concurrent.atomic=ALL-UNNAMED',
                '--add-opens=java.base/sun.nio.ch=ALL-UNNAMED',
                '--add-opens=java.base/sun.nio.cs=ALL-UNNAMED',
                '--add-opens=java.base/sun.security.action=ALL-UNNAMED',
                '--add-opens=java.base/sun.util.calendar=ALL-UNNAMED',
                '--add-opens=java.security.jgss/sun.security.krb5=ALL-UNNAMED',
                '-jar',
                vim.fn.expand '~/source/opensource/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
                '-configuration',
                vim.fn.expand '~/source/opensource/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac_arm',
                '-data',
                vim.fn.expand '~/.local/share/jdtls-workspaces/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t'),
            },
            settings = {
                java = {
                    references = {
                        includeDecompiledSources = true,
                    },
                    maven = {
                        downloadSources = true,
                    },
                    signatureHelp = { enabled = true },
                    contentProvider = { preferred = 'fernflower' },
                    completion = {
                        favoriteStaticMembers = {
                            'org.hamcrest.MatcherAssert.assertThat',
                            'org.hamcrest.Matchers.*',
                            'org.hamcrest.CoreMatchers.*',
                            'org.junit.jupiter.api.Assertions.*',
                            'java.util.Objects.requireNonNull',
                            'java.util.Objects.requireNonNullElse',
                            'org.mockito.Mockito.*',
                        },
                        filteredTypes = {
                            'com.sun.*',
                            'io.micrometer.shaded.*',
                            'java.awt.*',
                            'jdk.*',
                            'sun.*',
                        },
                    },
                    format = {
                        enabled = true,
                        -- settings = {
                        --     url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
                        -- },
                    },
                    -- signatureHelp = {
                    --     enabled = true,
                    -- },
                },
            },
            -- filetypes = { 'java' },
            -- capabilities = {},
            -- init_options = {
            --     bundles = {
            --         vim.fn.expand '~/source/opensource/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.0.jar',
            --     },
            -- },
        }

        require('lspconfig').bashls.setup {
            filetypes = { 'sh', 'bash', 'zsh' },
            single_file_support = true,
            root_dir = require('lspconfig/util').root_pattern('.git', '.bashrc', '.zshrc', '.bash_profile', '.bash_login', '.profile') or vim.fn.getcwd(),
        }

        require('lspconfig').gopls.setup {}

        require('lspconfig').clangd.setup {}

        require('lspconfig').rust_analyzer.setup {}

        vim.diagnostic.config {
            virtual_text = true,
            update_in_insert = true,
        }

        local keymaps = require 'vimnastics.global.keymaps'
        keymaps.set_lsp_keymaps()
    end,
}
-- Keeping old comments for reference to lsp on attach actions and capabilities
-- [[
-- vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('vimnastics-lsp-attach', { clear = true }),
--     callback = function(event)
--         local client = vim.lsp.get_client_by_id(event.data.client_id)
--         if not client then
--             return
--         end
--         if client.name == 'copilot' then
--             return
--         end
--
--         if client.server_capabilities.documentHighlightProvider then
--             local highlight_augroup = vim.api.nvim_create_augroup('vimnastics-lsp-highlight', { clear = false })
--             vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--                 buffer = event.buf,
--                 group = highlight_augroup,
--                 callback = vim.lsp.buf.document_highlight,
--             })
--             vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
--                 buffer = event.buf,
--                 group = highlight_augroup,
--                 callback = vim.lsp.buf.clear_references,
--             })
--             vim.api.nvim_create_autocmd('LspDetach', {
--                 group = vim.api.nvim_create_augroup('vimnastics-lsp-detach', { clear = true }),
--                 callback = function(event2)
--                     vim.lsp.buf.clear_references()
--                     vim.api.nvim_clear_autocmds { group = 'vimnastics-lsp-highlight', buffer = event2.buf }
--                 end,
--             })
--         end
--         if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
--             map('<leader>tih', function()
--                 vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
--             end, '[T]oggle Inlay [H]ints')
--         end
--     end,
-- })
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
--
--             local server = servers[server_name] or {}
--             -- This handles overriding only values explicitly passed
--             -- by the server configuration above. Useful when disabling
--             -- certain features of an LSP (for example, turning off formatting for tsserver)
--             server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
--             require('lspconfig')[server_name].setup(server)
-- ]]
