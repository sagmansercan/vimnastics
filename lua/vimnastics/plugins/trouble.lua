return {
    'folke/trouble.nvim',
    branch = 'main',
    event = 'VeryLazy',
    -- keys = {
    --     {
    --         '<leader>trw',
    --         '<cmd>Trouble diagnostics toggle<cr>',
    --         desc = 'Diagnostics (Trouble)',
    --     },
    --     {
    --         '<leader>trc',
    --         '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
    --         desc = 'Buffer Diagnostics (Trouble)',
    --     },
    --     {
    --         '<leader>cs',
    --         '<cmd>Trouble symbols toggle focus=false<cr>',
    --         desc = 'Symbols (Trouble)',
    --     },
    --     {
    --         '<leader>cl',
    --         '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
    --         desc = 'LSP Definitions / references / ... (Trouble)',
    --     },
    --     {
    --         '<leader>xL',
    --         '<cmd>Trouble loclist toggle<cr>',
    --         desc = 'Location List (Trouble)',
    --     },
    --     {
    --         '<leader>xQ',
    --         '<cmd>Trouble qflist toggle<cr>',
    --         desc = 'Quickfix List (Trouble)',
    --     },
    -- },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    config = function()
        local trouble = require 'trouble'
        trouble.setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
        local keymaps = require 'vimnastics.global.keymaps'
        keymaps.set_trouble_keymaps(trouble)
    end,
}
