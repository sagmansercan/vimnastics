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
    { 'tpope/vim-sleuth' }, -- auto shiftwidth, expandtab
    { 'christoomey/vim-tmux-navigator' },
    { 'numToStr/Comment.nvim', opts = {} },
    {
        'tpope/vim-fugitive',
        dependencies = { 'tpope/vim-rhubarb' }, -- GBrowse for GitHub
    },
    require 'vimnastics.plugins.gitsigns',
    require 'vimnastics.plugins.telescope',
    require 'vimnastics.plugins.lsp',
    require 'vimnastics.plugins.conform',
    require 'vimnastics.plugins.cmp',
    require 'vimnastics.plugins.mini',
    require 'vimnastics.plugins.dap',
    require 'vimnastics.plugins.treesitter',
    require 'vimnastics.plugins.lint',
    require 'vimnastics.plugins.autopairs',
    require 'vimnastics.plugins.neo-tree',
    require 'vimnastics.plugins.trouble',
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            signs = false,
        },
    },
    require 'vimnastics.plugins.copilot',
    {
        'mfussenegger/nvim-jdtls',
        dependencies = {
            'mfussenegger/nvim-dap',
            require 'vimnastics.plugins.lsp_signature',
            require 'vimnastics.plugins.lspsaga',
        },
    },
    -- { import = 'custom.plugins' },
}, {
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
