-- nvim-jdtls, not jdtls directly
local M = {}

function M.setup()
    local jdtls = require 'jdtls'
    local jdtls_dap = require 'jdtls.dap'
    local jdtls_setup = require 'jdtls.setup'
    local home = os.getenv 'HOME'
    local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
    -- local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml' }
    local root_dir = jdtls_setup.find_root(root_markers)
    local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
    local workspace_dir = home .. '/.cache/jdtls/workspace' .. project_name

    -- external deps:
    -- - java language server -> https://github.com/eclipse-jdtls/eclipse.jdt.ls
    -- - java debug adapter -> https://github.com/microsoft/java-debug
    -- - debug support for java test -> https://github.com/microsoft/vscode-java-test
    -- - lombok: getters and setters decorator -> https://github.com/projectlombok/lombok
    -- NOTE: PERSONAL CONFIGURATION
    local opensource_repos_path = home .. '/source/opensource'
    local custom_binaries_path = home .. '/source/bin'
    local path_jdtls_config = opensource_repos_path .. '/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac_arm/'
    -- NOTE: PERSONAL CONFIGURATION

    local path_jdtls_jar = opensource_repos_path
        .. '/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.800.v20240426-1701.jar' -- NOTE: review version
    local path_jdebug_jar = opensource_repos_path .. '/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.52.0.jar' -- NOTE: review version
    local path_jtest_jar = opensource_repos_path .. '/vscode-java-test/server/*.jar'
    local lombok_path = custom_binaries_path .. '/java/lombok.jar'

    local bundles = {
        vim.fn.glob(path_jdebug_jar, true),
    }

    vim.list_extend(bundles, vim.split(vim.fn.glob(path_jtest_jar, true), '\n'))

    -- LSP settings for Java.
    local on_attach = function(_, bufnr)
        jdtls.setup_dap { config_overrides = { hotcodereplace = 'auto' } }
        jdtls_dap.setup_dap_main_class_configs()

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_) vim.lsp.buf.format() end, { desc = 'Format current buffer with LSP' })

        --
        -- -- NOTE: comment out if you don't use Lspsaga
        -- require('lspsaga').init_lsp_saga()
    end

    local capabilities = {
        workspace = {
            configuration = true,
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
        },
    }

    local config = {
        flags = {
            allow_incremental_sync = true,
        },
    }

    config.cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx3g',
        '-javaagent:' .. lombok_path,
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        path_jdtls_jar,
        '-configuration',
        path_jdtls_config,
        '-data',
        workspace_dir,
    }

    config.settings = {
        java = {
            -- references = {
            --   includeDecompiledSources = true,
            -- },
            -- format = {
            --   enabled = true,
            --   settings = {
            --     url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
            --     profile = "GoogleStyle",
            --   },
            -- },
            -- eclipse = {
            --   downloadSources = true,
            -- },
            -- maven = {
            --   downloadSources = true,
            -- },
            -- signatureHelp = { enabled = true },
            -- contentProvider = { preferred = "fernflower" },
            -- -- eclipse = {
            -- -- 	downloadSources = true,
            -- -- },
            -- -- implementationsCodeLens = {
            -- -- 	enabled = true,
            -- -- },
            -- completion = {
            --   favoriteStaticMembers = {
            --     "org.hamcrest.MatcherAssert.assertThat",
            --     "org.hamcrest.Matchers.*",
            --     "org.hamcrest.CoreMatchers.*",
            --     "org.junit.jupiter.api.Assertions.*",
            --     "java.util.Objects.requireNonNull",
            --     "java.util.Objects.requireNonNullElse",
            --     "org.mockito.Mockito.*",
            --   },
            --   filteredTypes = {
            --     "com.sun.*",
            --     "io.micrometer.shaded.*",
            --     "java.awt.*",
            --     "jdk.*",
            --     "sun.*",
            --   },
            --   importOrder = {
            --     "java",
            --     "javax",
            --     "com",
            --     "org",
            --   },
            -- },
            -- sources = {
            --   organizeImports = {
            --     starThreshold = 9999,
            --     staticStarThreshold = 9999,
            --   },
            -- },
            -- codeGeneration = {
            --   toString = {
            --     template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            --     -- flags = {
            --     -- 	allow_incremental_sync = true,
            --     -- },
            --   },
            --   useBlocks = true,
            -- },
            -- -- configuration = {
            -- --     runtimes = {
            -- --         {
            -- --             name = "java-17-openjdk",
            -- --             path = "/usr/lib/jvm/default-runtime/bin/java"
            -- --         }
            -- --     }
            -- -- }
            -- -- project = {
            -- -- 	referencedLibraries = {
            -- -- 		"**/lib/*.jar",
            -- -- 	},
            -- -- },
        },
    }

    config.on_attach = on_attach
    config.capabilities = capabilities
    config.on_init = function(client, _) client.notify('workspace/didChangeConfiguration', { settings = config.settings }) end

    local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    config.init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities,
    }

    -- Start Server
    require('jdtls').start_or_attach(config)

    -- -- Set Java Specific Keymaps
    -- require 'jdtls.keymaps'
end

return M
