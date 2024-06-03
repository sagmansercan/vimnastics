require 'vimnastics.global.options'
require 'vimnastics.global.autocmds'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    require 'vimnastics.plugins.tokyonight',
    {
        'tpope/vim-sleuth',
        event = 'VeryLazy',
    }, -- auto shiftwidth, expandtab
    {
        'christoomey/vim-tmux-navigator',
        event = 'VeryLazy',
    },
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'tpope/vim-fugitive',
        event = 'VeryLazy',
        dependencies = { 'tpope/vim-rhubarb' }, -- GBrowse for GitHub
    },
    require 'vimnastics.plugins.harpoon',
    require 'vimnastics.plugins.gitsigns',
    require 'vimnastics.plugins.telescope',
    require 'vimnastics.plugins.cmp',
    require 'vimnastics.plugins.lsp',
    require 'vimnastics.plugins.conform',
    require 'vimnastics.plugins.mini',
    require 'vimnastics.plugins.dap',
    require 'vimnastics.plugins.treesitter',
    require 'vimnastics.plugins.lint',
    require 'vimnastics.plugins.autopairs',
    require 'vimnastics.plugins.neo-tree',
    require 'vimnastics.plugins.trouble',
    {
        'folke/todo-comments.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            signs = false,
        },
    },
    {
        'nvim-java/nvim-java',
        dependencies = {
            'nvim-java/lua-async-await',
            'nvim-java/nvim-java-refactor',
            'nvim-java/nvim-java-core',
            'nvim-java/nvim-java-test',
            'nvim-java/nvim-java-dap',
            'MunifTanjim/nui.nvim',
            'neovim/nvim-lspconfig',
            'mfussenegger/nvim-dap',
            {
                'williamboman/mason.nvim',
                opts = {
                    registries = {
                        'github:nvim-java/mason-registry',
                        'github:mason-org/mason-registry',
                    },
                },
            },
        },
    },
    {
        'scalameta/nvim-metals',
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'j-hui/fidget.nvim',
                opts = {},
            },
            {
                'mfussenegger/nvim-dap',
            },
        },
        -- ft = { 'scala', 'sbt', 'java' },
        ft = { 'scala', 'sbt' },
        opts = function()
            local metals_config = require('metals').bare_config()

            metals_config.settings = {
                showImplicitArguments = true,
                -- excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
            }

            metals_config.init_options.statusBarProvider = 'on'

            metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

            metals_config.on_attach = function(client, bufnr)
                require('metals').setup_dap()
            end

            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                pattern = self.ft,
                callback = function()
                    require('metals').initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end,
    },
    {
        'ellisonleao/glow.nvim',
        config = true,
        cmd = 'Glow',
    },
    require 'vimnastics.plugins.copilot',
    {
        'mbbill/undotree',
        event = 'VeryLazy',
    },
    {
        'rasulomaroff/reactive.nvim',
        event = 'VeryLazy',
        config = function()
            require('reactive').setup {
                builtin = {
                    cursorline = true,
                    cursor = true,
                    modemsg = true,
                },
            }
        end,
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        event = 'VeryLazy',
        dependencies = {
            { 'tpope/vim-dadbod' },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_winwidth = 60
            -- vim.g.db_ui_disable_mappings = 1
        end,
    },
    {
        'sagmansercan/nvim-llama',
        event = 'VeryLazy',
        opts = {},
    },
    -- { import = 'custom.plugins' },
}, {
    defaults = {
        lazy = true,
    },
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})
