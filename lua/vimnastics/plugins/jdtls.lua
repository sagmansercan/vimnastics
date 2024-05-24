-- nvim-jdtls, not jdtls directly
local M = {}
local home = os.getenv 'HOME' .. '/'

local function get_java_debug_bundles()
    local project_path_prefix = 'source/opensource/'
    local project_folder = 'java-debug/'
    local java_debug_project_path = home .. project_path_prefix .. project_folder
    local glob_1 = java_debug_project_path .. '/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'
    return vim.split(vim.fn.glob(glob_1, true), '\n')
end

local function get_vscode_java_test_bundles()
    local project_path_prefix = 'source/opensource/'
    local project_folder = 'vscode-java-test/'
    local vscode_java_test_project_path = home .. project_path_prefix .. project_folder
    local glob_1 = vscode_java_test_project_path .. '/server/*.jar'
    -- local glob_2 = vscode_java_test_project_path .. 'java-extension/com.microsoft.java.test.plugin/target/*.jar'
    -- local glob_3 = vscode_java_test_project_path .. 'java-extension/com.microsoft.java.test.runner/target/*.jar'
    -- local glob_4 = vscode_java_test_project_path .. 'java-extension/com.microsoft.java.test.runner/lib/*.jar'
    -- local glob_5 = vscode_java_test_project_path .. '/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/*.jar'

    local bundles = {}
    vim.list_extend(bundles, vim.split(vim.fn.glob(glob_1, true), '\n'))
    -- vim.list_extend(bundles, vim.split(vim.fn.glob(glob_2, true), '\n'))
    -- vim.list_extend(bundles, vim.split(vim.fn.glob(glob_3, true), '\n'))
    -- vim.list_extend(bundles, vim.split(vim.fn.glob(glob_4, true), '\n'))
    -- vim.list_extend(bundles, vim.split(vim.fn.glob(glob_5, true), '\n'))

    local excluded_bundles = {
        'com.microsoft.java.test.runner-jar-with-dependencies.jar',
        'jacocoagent.jar',
        -- 'com.microsoft.java.test.runner.jar',
    }

    local filtered_bundles = {}
    for _, bundle in ipairs(bundles) do
        local is_excluded = false
        for _, excluded_bundle in ipairs(excluded_bundles) do
            if vim.endswith(bundle, excluded_bundle) then
                is_excluded = true
                break
            end
        end

        if not is_excluded then
            table.insert(filtered_bundles, bundle)
        end
    end

    return filtered_bundles
end

local function get_bundles()
    local bundles = {}
    vim.list_extend(bundles, get_java_debug_bundles())
    vim.list_extend(bundles, get_vscode_java_test_bundles())

    return bundles
end

function M.setup()
    local jdtls = require 'jdtls'
    local jdtls_dap = require 'jdtls.dap'
    local jdtls_setup = require 'jdtls.setup'
    local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
    -- local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml' }
    local root_dir = jdtls_setup.find_root(root_markers)
    local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
    local workspace_dir = home .. '/.cache/jdtls/workspace/' .. project_name

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
    local lombok_path = custom_binaries_path .. '/java/lombok.jar'

    -- LSP settings for Java.
    local on_attach = function(_, bufnr)
        jdtls.setup_dap { config_overrides = { hotcodereplace = 'auto' } }
        jdtls_dap.setup_dap_main_class_configs()
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
            contentProvider = { preferred = 'fernflower' },
            eclipse = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            references = {
                includeAccessors = true,
                includeDecompiledSources = true,
            },
            signatureHelp = { enabled = true },
            format = {
                enabled = true,
                settings = {
                    -- url = 'https://github.com/google/google-java-format',
                    url = 'https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml',
                    profile = 'GoogleStyle',
                },
            },
            maven = {
                downloadSources = true,
            },
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
    config.on_init = function(client, _)
        client.notify('workspace/didChangeConfiguration', { settings = config.settings })
    end

    local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    config.init_options = {
        bundles = get_bundles(),
        extendedClientCapabilities = extendedClientCapabilities,
    }

    -- Start Server
    require('jdtls').start_or_attach(config)
end

return M
