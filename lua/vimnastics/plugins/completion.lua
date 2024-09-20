return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        -- 'onsails/lspkind.nvim', -- TODO: under review
    },
    config = function()
        local cmp = require 'cmp'
        local keymaps = require 'vimnastics.global.keymaps'
        -- local lspkind = require 'lspkind'

        cmp.setup {
            completion = {
                completeopt = 'menu,menuone,noinsert',
                -- autocomplete = false,
                -- keyword_length = 2,
            },
            -- ---@diagnostic disable-next-line: missing-fields
            -- formatting = {
            --     format = lspkind.cmp_format {
            --         maxwidth = 80,
            --         -- -- can also be a function to dynamically calculate max width such as
            --         -- -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            --         ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            --         show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            --
            --         -- mode = 'symbol', -- show only symbol annotations
            --         -- symbol_map = {
            --         -- },
            --
            --         mode = 'symbol_text',
            --         menu = {
            --             buffer = '[Buffer]',
            --             nvim_lsp = '[LSP]',
            --             nvim_lua = '[Lua]',
            --             latex_symbols = '[Latex]',
            --         },
            --
            --         -- -- The function below will be called before any actual modifications from lspkind
            --         -- -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            --         -- before = function (entry, vim_item)
            --         --   ...
            --         --   return vim_item
            --         -- end
            --     },
            -- },

            -- `:help ins-completion`
            mapping = keymaps.set_cmp_keymaps(),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'buffer' },
                -- { name = 'vim-dadbod-completion' },
            },
            window = {
                completion = {
                    border = 'rounded',
                },
                documentation = {
                    max_width = 150,
                    max_height = 5,
                },
            },
        }
    end,
}
