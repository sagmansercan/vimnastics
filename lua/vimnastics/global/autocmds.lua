vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('vimnastics-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank {
            timeout_ms = 400,
        }
    end,
})

vim.cmd [[
augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua require'vimnastics.plugins.jdtls'.setup()
augroup end
]]
