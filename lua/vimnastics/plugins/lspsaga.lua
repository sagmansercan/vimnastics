return {
    'nvimdev/lspsaga.nvim',
    event = 'VeryLazy',
    config = function()
        require('lspsaga').setup {
            finder = {
                default = 'def+ref+imp',
                layout = 'normal', -- normal | float
                keys = {
                    shuttle = '<C-u>',
                },
            },
            lightbulb = {
                enable = false,
            },
            outline = {
                layout = 'float', -- normal | float
            },
        }

        vim.keymap.set('n', 'gr', '<cmd>Lspsaga finder ref<CR>', { desc = 'Lspsaga: references' })
        vim.keymap.set('n', 'gi', '<cmd>Lspsaga finder imp<CR>', { desc = 'Lspsaga: implementation' })
        vim.keymap.set('n', 'gR', '<cmd>Lspsaga rename<CR>', { desc = 'Lspsaga: rename' })
        vim.keymap.set('n', '<leader>ds', '<cmd>Lspsaga outline<CR>', { desc = 'Lspsaga: outline' })
        vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = 'Lspsaga: code action' })
        vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = 'Lspsaga: hover doc' })
        vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', { desc = 'Lspsaga: go to definition' })
        vim.keymap.set('n', 'gD', '<cmd>Lspsaga goto_type_definition<CR>', { desc = 'Lspsaga: go to type definition' })
        vim.keymap.set('n', 'gpd', '<cmd>Lspsaga peek_definition<CR>', { desc = 'Lspsaga: go to definition' })
        vim.keymap.set('n', 'gpD', '<cmd>Lspsaga peek_type_definition<CR>', { desc = 'Lspsaga: go to type definition' })
        vim.keymap.set('n', 'tt', '<cmd>Lspsaga term_toggle<CR>', { desc = 'Lspsaga: pop up terminal' })
    end,
    dependencies = {
        require 'vimnastics.plugins.treesitter',
    },
}
