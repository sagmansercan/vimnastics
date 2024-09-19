M = {}
-- Single strokes
-- ESC -> no highlight
vim.keymap.set('n', '<Esc>', '<C-c><cmd>nohl<CR>', { desc = 'write file' })
vim.keymap.set('n', '<F1>', '<cmd>ToggleTerm<CR>', { desc = 'write file' })
vim.keymap.set('t', '<F1>', '<C-\\><C-n>:ToggleTerm<CR>', { desc = 'Toggle terminal in terminal mode' })

-- arrow keys -> disable navigation via arrow keys in normal mode
vim.keymap.set('n', '<left>', '')
vim.keymap.set('n', '<right>', '')
vim.keymap.set('n', '<up>', '')
vim.keymap.set('n', '<down>', '')

-- <, > -> continous indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Multiple key strokes
-- Letters
vim.keymap.set('i', 'jj', '<C-c>', { desc = 'Exit insert mode' })
vim.keymap.set('i', 'kk', '<C-c>', { desc = 'Exit insert mode' })
-- Cmd
-- `C` is for Ctrl, but here all the keymaps are set according to Cmd key on Mac. So
-- if a <C-key> combination is set here, it means it is also hexmapped in iterm2 config.
-- C-a -> reserved for tmux prefix
-- C-b -> Buffers, see set_telescope_keymaps // default: scroll back one full screen
-- C-c -> this one can be a little tricky because it is exiting from insert mode and likely to be excesivvely pressed
-- right after switching into the normal mode(C-c C-c C-c ...)
-- So, it may be better to use this like 'safe and repeatable operations'. I prefer not using it
-- C-e -> select all
vim.keymap.set('n', '<C-e>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('v', '<C-e>', '<C-c>ggVG', { desc = 'Select all' })
-- C-f -> Find files, see set_telescope_keymaps // default: scroll forward one full screen
-- C-g -> git files, see set_telescope_keymaps
-- C-i -> builtin: go to next cursor position
-- C-hjlk -> window navigation inside neovim
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- C-m -> builtin: Enter. DO NOT CONFIGURE
-- C-n -> builtin: next line same column. C-n and C-p are convenient for moving cursor up and down in many cases
-- C-p -> builtin: previous line same column. Optionally configurable
-- C-r -> builtin: redo
-- C-s -> Save changes
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save changes' })
vim.keymap.set('i', '<C-s>', '<C-c><cmd>w<CR>', { desc = 'Save changes' })
-- C+t -> builtin in tagstack ops (?)
-- C+u -> builtin page navigation. Works well with C+d
-- C+v -> builtin paste. Equivalent to `p`, reconfigurable
-- C+w -> reserved in terminal to close iterm2
-- C-x -> Close buffer
vim.keymap.set('n', '<C-x>', '<cmd>bdelete<CR>', { desc = 'Close buffer' })
-- vim.keymap.set('n', '<C-y><C-x>', '<cmd>bdelete!<CR>', { desc = 'Close buffer ignore changes' })
-- C+y -> Live grep, see set_telescope_keymaps // builtin move screen one line up.
-- C+z -> reserved in terminal to suspend neovim process and go back to shell which current neovim instance is opened

-- Leader
-- leader-a
-- leader-b
-- leader-c
-- leader-d
-- leader-e
-- leader-f
vim.keymap.set('n', '<leader>s', '/', { desc = 'Search in buffer' })
-- leader-n -> Next buffer
vim.keymap.set('n', '<leader>n', '<cmd>bn<CR>', { desc = 'Next buffer' })
-- leader-p -> Previous buffer
vim.keymap.set('n', '<leader>p', '<cmd>bp<CR>', { desc = 'Previous buffer' })
-- leader-q
vim.keymap.set('n', '<leader>qA', '<cmd>qa!<CR>', { desc = 'Abort changes and Quit Nvim' })
vim.keymap.set('n', '<leader>qa', '<cmd>qa<CR>', { desc = 'Quit Nvim' })
-- leader-w
-- vim.keymap.set('n', '<leader>wa', '<cmd>qa!<CR>', { desc = 'Abort Changes and Quit Nvim' })
vim.keymap.set('n', '<leader>we', '<cmd>%bd|e#|bd#<CR>', { desc = 'Delete all buffers except current' })
-- vim.keymap.set('n', '<leader>wQ', '<cmd>wq<CR>', { desc = 'Save and Quit Nvim' })
vim.keymap.set('n', '<leader>ww', '<cmd>bd<CR>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>wW', '<cmd>bd!<CR>', { desc = 'Abort Changes and Delete buffer' })
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

M.set_telescope_keymaps = function(telescope_custom_functions)
    -- Cmd
    vim.keymap.set('n', '<C-b>', '<cmd>Telescope buffers layout_strategy=center<CR>', { desc = 'Find files' })
    vim.keymap.set('n', '<C-f>', '<cmd>Telescope find_files layout_strategy=vertical<CR>', { desc = 'Find files' })
    vim.keymap.set('n', '<C-g>', '<cmd>Telescope git_files layout_strategy=vertical<CR>', { desc = 'Find files' })
    vim.keymap.set('n', '<C-y>', telescope_custom_functions.pick_vertical(require('telescope.builtin').live_grep), { desc = 'Telescope Live Grep' })

    -- Leader
    vim.keymap.set('n', '<leader>tc', '<cmd>Telescope lsp_code_actions<CR>', { desc = 'Find files' })
    vim.keymap.set('n', '<leader>td', '<cmd>Telescope diagnostics layout_strategy=bottom_pane<CR>', { desc = 'Find files' })
    vim.keymap.set('n', '<leader>tf', '<cmd>Telescope file_browser layout_strategy=vertical<CR>', { desc = 'buffers' })
    vim.keymap.set('n', '<leader>th', '<cmd>Telescope help_tags<CR>', { desc = 'Find files' })
    vim.keymap.set('n', '<leader>tq', '<cmd>Telescope quickfix<CR>', { desc = 'Find files' })
    vim.keymap.set('n', '<leader>tr', '<cmd>Telescope lsp_references<CR>', { desc = 'Find files' })
    vim.keymap.set('n', '<leader>ts', '<cmd>Telescope lsp_document_symbols<CR>', { desc = 'Find files' })
end

M.set_dap_keymaps = function(dap)
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F8>', dap.close, { desc = 'Debug: Close' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = 'DAPrepl toggle' })
    vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    -- vim.keymap.set('n', '<leader>do', dapui.open, { desc = 'DAPUI open' })
    -- vim.keymap.set('n', '<leader>dc', dapui.close, { desc = 'DAPUI Close' })
    -- vim.keymap.set('n', '<leader>dro', dap.repl.open, { desc = 'DAPrepl open' })
    -- vim.keymap.set('n', '<leader>drc', dap.repl.close, { desc = 'DAPrepl close' })
    --
    -- vim.keymap.set('n', '<leader>djtc', '<cmd>JavaTestDebugCurrentClass<CR>', { desc = 'nvim-java: test current class' })
    -- vim.keymap.set('n', '<leader>djtm', '<cmd>JavaTestDebugCurrentMethod<CR>', { desc = 'nvim-java: test current method' })
end

M.set_trouble_keymaps = function(trouble)
    vim.keymap.set('n', '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Toggle Document Diagnostics' })
    vim.keymap.set('n', '<leader>xa', '<cmd>Trouble diagnostics toggle<CR>', { desc = 'Toggle All Diagnostics' })
end

return M
