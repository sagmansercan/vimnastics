return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require 'gitsigns'

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- normal mode
                map('n', '<leader>eR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
                map('n', '<leader>eb', gitsigns.blame_line, { desc = 'git [b]lame line' })
                map('n', '<leader>ed', gitsigns.diffthis, { desc = 'git [d]iff against index' })
                map('n', '<leader>eD', function() gitsigns.diffthis '@' end, { desc = 'git [D]iff against last commit' })
                -- Toggles
                map('n', '<leader>etb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
                map('n', '<leader>etD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
            end,
        },
    },
}
