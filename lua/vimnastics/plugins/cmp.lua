return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            build = (function()
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
            dependencies = {
                {
                    'rafamadriz/friendly-snippets',
                    config = function()
                        require('luasnip.loaders.from_vscode').lazy_load()
                    end,
                },
            },
        },
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'onsails/lspkind.nvim',
    },
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        local lspkind = require 'lspkind'

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = 'menu,menuone,noinsert' },
            ---@diagnostic disable-next-line: missing-fields
            formatting = {
                format = lspkind.cmp_format {
                    -- mode = 'symbol', -- show only symbol annotations
                    -- maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    -- -- can also be a function to dynamically calculate max width such as
                    -- -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                    -- ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    -- show_labelDetails = true, -- show labelDetails in menu. Disabled by default
                    --
                    -- -- -- The function below will be called before any actual modifications from lspkind
                    -- -- -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    -- -- before = function (entry, vim_item)
                    -- --   ...
                    -- --   return vim_item
                    -- -- end
                    -- symbol_map = {
                    --     Copilot = '',
                    -- },
                    mode = 'symbol_text',
                    menu = {
                        copilot = '[AI]',
                        buffer = '[Buffer]',
                        nvim_lsp = '[LSP]',
                        luasnip = '[LuaSnip]',
                        nvim_lua = '[Lua]',
                        latex_symbols = '[Latex]',
                    },
                },
            },

            -- `:help ins-completion`
            mapping = cmp.mapping.preset.insert {
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-y>'] = cmp.mapping.confirm { select = true },
                ['<CR>'] = cmp.mapping.confirm { select = true }, -- TODO: xperiment
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
            },
            sources = {
                { name = 'copilot' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
            },
        }
    end,
}
