return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            -- on_attach = function(bufnr)
            --     local gitsigns = require 'gitsigns'
            --
            --     local function map(mode, l, r, opts)
            --         opts = opts or {}
            --         opts.buffer = bufnr
            --         vim.keymap.set(mode, l, r, opts)
            --     end
            --
            --     map('n', '<leader>erb', gitsigns.reset_buffer, { desc = 'git geset buffer' })
            --     map('n', '<leader>ebl', gitsigns.blame_line, { desc = 'git blame line' })
            --     map('n', '<leader>edi', gitsigns.diffthis, { desc = 'git diff against index' })
            --     map('n', '<leader>edl', function() gitsigns.diffthis '@' end, { desc = 'git diff against last commit' })
            --     map('n', '<leader>etb', gitsigns.toggle_current_line_blame, { desc = 'toggle git show blame line' })
            --     map('n', '<leader>etd', gitsigns.toggle_deleted, { desc = 'toggle git show deleted' })
            -- end,
        },
    },
}
