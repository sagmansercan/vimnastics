require 'vimnastics.global.globals'
require 'vimnastics.global.options'
require 'vimnastics.global.keymaps'
require 'vimnastics.global.autocmds'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- essential plugins may be required by various plugins
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-tree/nvim-web-devicons' },

    -- visuals/color/themes etc.
    require 'vimnastics.plugins.tokyonight',
    require 'vimnastics.plugins.lualine',
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

    -- formatting/style/navigation/utilities
    {
        'tpope/vim-sleuth',
        event = 'VeryLazy',
    }, -- auto shiftwidth, expandtab
    {
        'christoomey/vim-tmux-navigator',
        event = 'VeryLazy',
    },
    {
        'mbbill/undotree',
        event = 'VeryLazy',
    },
    require 'vimnastics.plugins.autopairs',
    require 'vimnastics.plugins.conform',
    -- {
    --     'numToStr/Comment.nvim',
    --     event = 'VeryLazy',
    --     opts = {},
    -- },

    -- git
    {
        'tpope/vim-fugitive',
        event = 'VeryLazy',
        dependencies = { 'tpope/vim-rhubarb' }, -- GBrowse for GitHub
    },
    require 'vimnastics.plugins.gitsigns',

    -- here comes some serious stuff
    require 'vimnastics.plugins.treesitter',
    require 'vimnastics.plugins.lsp',
    require 'vimnastics.plugins.completion',
    require 'vimnastics.plugins.telescope',
    require 'vimnastics.plugins.dap',
    require 'vimnastics.plugins.trouble',
    -- {
    --     'folke/todo-comments.nvim',
    --     event = 'VeryLazy',
    --     opts = {
    --         signs = false,
    --     },
    -- },

    -- AI
    require 'vimnastics.plugins.copilot',
    -- {
    --     'sagmansercan/nvim-llama',
    --     event = 'VeryLazy',
    --     opts = {},
    -- },

    -- {
    --     'kristijanhusak/vim-dadbod-ui',
    --     event = 'VeryLazy',
    --     dependencies = {
    --         { 'tpope/vim-dadbod' },
    --         { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } },
    --     },
    --     cmd = {
    --         'DBUI',
    --         'DBUIToggle',
    --         'DBUIAddConnection',
    --         'DBUIFindBuffer',
    --     },
    --     init = function()
    --         -- Your DBUI configuration
    --         vim.g.db_ui_use_nerd_fonts = 1
    --         vim.g.db_ui_winwidth = 60
    --         -- vim.g.db_ui_disable_mappings = 1
    --     end,
    -- },
    -- {
    --     'sagmansercan/nvim-popterm',
    --     event = 'VeryLazy',
    --     opts = {},
    -- },
    -- {
    --     'cappyzawa/trim.nvim',
    --     event = 'VeryLazy',
    --     opts = {},
    -- },
    -- {
    --     'iamcco/markdown-preview.nvim',
    --     event = 'VeryLazy',
    --     cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    --     ft = { 'markdown' },
    --     build = function()
    --         vim.fn['mkdp#util#install']()
    --     end,
    -- },
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
