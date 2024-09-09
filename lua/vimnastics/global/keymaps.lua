M = {}
-- Single strokes
-- disable navigation via arrow keys in normal mode
vim.keymap.set('n', '<left>', '')
vim.keymap.set('n', '<right>', '')
vim.keymap.set('n', '<up>', '')
vim.keymap.set('n', '<down>', '')

-- continous indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Cmd
-- `C` is for Ctrl, but here all the keymaps are set according to Cmd key on Mac. So
-- if a <C-key> combination is set here, it means it is also hexmapped in iterm2 config.

-- C-a -> reserved for tmux prefix
-- C-b -> default: scroll back one full screen
-- C-c -> this one can be a little tricky because it is exiting from insert mode and likely to be excesivvely pressed
-- right after switching into the normal mode(C-c C-c C-c ...)
-- So, it may be better to use this like 'safe and repeatable operations'. I picked no highlight
vim.keymap.set('n', '<Esc>', '<C-c><cmd>nohl<CR>', { desc = 'write file' })
-- C-e -> select all
vim.keymap.set('n', '<C-e>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('v', '<C-e>', '<C-c>ggVG', { desc = 'Select all' })
-- C-f -> default: scroll forward one full screen
vim.keymap.set('n', '<C-f>', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
-- C-g -> git files
vim.keymap.set('n', '<C-g>', '<cmd>Telescope git_files<CR>', { desc = 'Find files' })
-- C-i -> builtin: go to next cursor position
-- C-hjlk -> window navigation inside neovim
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- C-m -> builtin: Enter. Optionally configurable
-- C-n -> builtin: next line same column. Optionally configurable
-- C-p -> builtin: previous line same column. Optionally configurable
-- C-r -> builtin: redo
-- C-s -> search text in all files
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Move focus to the upper window' })
vim.keymap.set('i', '<C-s>', '<C-c><cmd>w<CR>', { desc = 'Move focus to the upper window' })
-- C+t -> builtin in tagstack ops (?)
-- C+u -> builtin page navigation. Works well with C+d
-- C+v -> builtin paste. Equivalent to `p`, reconfigurable
-- C+w -> reserved in terminal to close iterm2
-- C-x -> Close buffer
vim.keymap.set('n', '<C-x>', '<cmd>bdelete<CR>', { desc = 'Close buffer' })
-- vim.keymap.set('n', '<C-y><C-x>', '<cmd>bdelete!<CR>', { desc = 'Close buffer ignore changes' })
-- C+y -> builtin move screen one line up.
vim.keymap.set('n', '<C-y>', '<cmd>Telescope live_grep<CR>', { desc = 'Telescope Live Grep' })
-- C+z -> reserved in terminal to suspend neovim process and go back to shell which current neovim instance is opened

-- Leader
-- leader-a
vim.keymap.set('n', '<leader>a', '<cmd>Telescope buffers<CR>', { desc = 'buffers' })

-- vim.keymap.set('n', '<leader>bD', '<cmd>bd!<CR>', { desc = 'force delete current buffer' })
-- vim.keymap.set('n', '<leader>be', '<cmd>%bd|e#|bd#<CR>', { desc = 'Delete all buffers except current' })
-- vim.keymap.set('n', '<leader>w', '<cmd>:q<CR>', { desc = 'Quit' })
-- vim.keymap.set('n', '<leader>q', '<cmd>:qa<CR>', { desc = 'Quit' })
-- vim.keymap.set('n', '<leader>s', '/', { desc = 'Search raw' })
-- vim.keymap.set('n', '<leader>n', '/<C-r>+<CR>', { desc = 'Search text from clipboard' })
-- vim.keymap.set('n', '-', '*', { desc = 'Search current word' })
-- vim.keymap.set('v', '<leader>n', 'y/<C-r>"<CR>', { desc = 'Search current word' })
-- vim.keymap.set('n', '<leader>gl', '<cmd>Glow<CR>', { desc = 'Glow markdown' })
-- vim.keymap.set('n', '<leader>eb', '<cmd>Git blame<CR>', { desc = 'Open all lines git blame' })
-- vim.keymap.set('n', '<leader>er', '<cmd>GBrowse<CR>', { desc = 'Git browse' })
-- vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle<CR>', { desc = 'Undo tree toggle' })
-- vim.keymap.set('v', '<leader>ec', '<cmd>ExplainCode<CR>', { desc = 'Explain code via llama' })
-- vim.keymap.set('n', '<F1>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
-- vim.keymap.set('t', '<F1>', '<C-\\><C-n>:ToggleTerm<CR>', { desc = 'Toggle terminal in terminal mode' })

--define a function to set keymaps for a plugin
M.set_lsp_keymaps = function()
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Go to definition' })
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = 'Go to declaration' })
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = 'Go to references' })
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = 'Go to implementation' })
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Show hover' })
    vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'Rename' })
end

M.set_cmp_keymaps = function(cmp)
    return cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        -- ['<CR>'] = cmp.mapping.confirm { select = true }, -- TODO: xperiment
        ['<C-g>'] = cmp.mapping.complete {},
        -- ['<C-l>'] = cmp.mapping(function()
        --     if luasnip.expand_or_locally_jumpable() then
        --         luasnip.expand_or_jump()
        --     end
        -- end, { 'i', 's' }),
        -- ['<C-h>'] = cmp.mapping(function()
        --     if luasnip.locally_jumpable(-1) then
        --         luasnip.jump(-1)
        --     end
        -- end, { 'i', 's' }),
    }
end

return M
