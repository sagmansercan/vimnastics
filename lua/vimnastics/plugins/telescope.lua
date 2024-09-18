-- local L = {}
-- L.pick_vertical = function(picker_fn)
--     return function()
--         picker_fn(require('telescope.themes').get_ivy {
--             border = true,
--             previewer = true,
--             layout_strategy = 'vertical',
--             layout_config = {
--                 -- width = 0.8,
--                 height = 0.9,
--             },
--             sorting_strategy = 'descending',
--             -- line_width = 0.7,
--             -- winblend = 10,
--             -- results_title = false,
--             -- preview_title = false,
--         })
--     end
-- end
--
return {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
        -- {
        --     enabled = vim.g.have_nerd_font
        -- },
        -- {
        --     'nvim-telescope/telescope-fzf-native.nvim',
        --     build = 'make',
        --     cond = function()
        --         return vim.fn.executable 'make' == 1
        --     end,
        -- },
        -- { 'nvim-telescope/telescope-ui-select.nvim' },
        -- { 'nvim-telescope/telescope-dap.nvim' },
    },
    config = function()
        --         local actions = require 'telescope.actions'
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = {
                    '^.git/',
                    '**/*.class$', -- compiled java classes
                    '^build/', -- gradle build
                    '^target/', -- maven target
                    '^node_modules/', -- node modules
                    '^venv/', -- python virtualenv
                },
                --                 mappings = {
                --                     i = {
                --                         ['<C-c>'] = actions.close,
                --                         ['<Down>'] = actions.cycle_history_next,
                --                         ['<Up>'] = actions.cycle_history_prev,
                --                         ['<C-j>'] = actions.move_selection_next,
                --                         ['<C-k>'] = actions.move_selection_previous,
                --                     },
                --                 },
                --                 -- vimgrep_arguments = {
                --                 --     'rg',
                --                 --     '--color=never',
                --                 --     '--no-heading',
                --                 --     '--with-filename',
                --                 --     '--line-number',
                --                 --     '--column',
                --                 --     '--smart-case',
                --                 -- },
                --                 -- find_command = { 'fd', '--type', 'f', '--hidden', '--smart-case', '--unrestricted' },
            },
            --             pickers = {
            --                 find_files = {
            --                     hidden = true,
            --                 },
            --             },
            --             extensions = {
            --                 ['ui-select'] = {
            --                     require('telescope.themes').get_dropdown(),
            --                 },
            --                 fzf = {
            --                     fuzzy = true,                   -- false will only do exact matching
            --                     override_generic_sorter = true, -- override the generic sorter
            --                     override_file_sorter = true,    -- override the file sorter
            --                     -- case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            --                     -- the default case_mode is "smart_case"
            --                 },
            --             },
        }
        --
        -- local builtin = require 'telescope.builtin'
        -- vim.keymap.set('n', '<leader>th', L.pick_vertical(builtin.help_tags), { desc = 'Search Help' })
        -- vim.keymap.set('n', '<leader>tk', L.pick_vertical(builtin.keymaps), { desc = 'Search Keymaps' })
        -- vim.keymap.set('n', '<leader>f', L.pick_vertical(builtin.find_files), { desc = 'Search Files' })
        -- vim.keymap.set('n', '<leader>y', L.pick_vertical(builtin.live_grep), { desc = 'Search by Grep' })
        -- vim.keymap.set('n', '<leader>o', L.pick_vertical(builtin.oldfiles), { desc = 'Search Recent Files ("." for repeat)' })
        -- vim.keymap.set('n', '<leader><leader>', L.pick_vertical(builtin.buffers), { desc = '[ ] Find existing buffers' })
        -- vim.keymap.set('n', '<leader>td', function()
        --     -- custom opts
        --     builtin.diagnostics(require('telescope.themes').get_ivy {
        --         previewer = false,
        --         layout_config = {
        --             -- width = 0.7,
        --             height = 0.6,
        --         },
        --         sorting_strategy = 'ascending',
        --         line_width = 0.7,
        --     })
        -- end, { desc = 'Search Diagnostics' })
        -- vim.keymap.set('n', '<leader>ts', function()
        --     builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        --         -- winblend = 1,
        --         previewer = false,
        --         layout_config = {
        --             width = 0.7,
        --         },
        --         sorting_strategy = 'descending',
        --     })
        -- end, { desc = 'Fuzzily search in current buffer' })
        keymaps.set_telescope_keymaps(M)
    end,
}

-- --[[
-- Example values:
--
-- theme layout config ref:
-- {
--   border = true,
--   borderchars = {
--     preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
--     prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
--     results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" }
--   },
--   layout_config = {
--     height = <function 1>,
--     preview_cutoff = 1,
--     width = <function 2>
--   },
--   layout_strategy = "center",
--   previewer = false,
--   results_title = false,
--   sorting_strategy = "ascending",
--   theme = "dropdown",
--   winblend = 10
-- }
--
-- --]]
