return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function() return vim.fn.executable 'make' == 1 end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
        local actions = require 'telescope.actions'
        require('telescope').setup {
            defaults = {
                file_ignore_patterns = { '^.git/*' },
                mappings = {
                    i = {
                        ['<C-c>'] = actions.close,
                        ['<Down>'] = actions.cycle_history_next,
                        ['<Up>'] = actions.cycle_history_prev,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        }

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>th', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>tk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>f', function()
            -- custom opts
            builtin.find_files(require('telescope.themes').get_ivy {
                border = false,
                previewer = true,
                layout_config = {
                    -- width = 0.8,
                    height = 0.6,
                },
                sorting_strategy = 'ascending',
                line_width = 0.7,
            })
        end, { desc = 'Search Files' })
        vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>td', function()
            -- custom opts
            builtin.diagnostics(require('telescope.themes').get_ivy {
                previewer = false,
                layout_config = {
                    -- width = 0.7,
                    height = 0.6,
                },
                sorting_strategy = 'ascending',
                line_width = 0.7,
            })
        end, { desc = 'Search Diagnostics' })
        vim.keymap.set('n', '<leader>o', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>s', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                -- winblend = 1,
                previewer = false,
                layout_config = {
                    width = 0.7,
                },
                sorting_strategy = 'descending',
            })
        end, { desc = 'Fuzzily search in current buffer' })
    end,
}

--[[
Example values:

theme layout config ref:
{
  border = true,
  borderchars = {
    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
    results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" }
  },
  layout_config = {
    height = <function 1>,
    preview_cutoff = 1,
    width = <function 2>
  },
  layout_strategy = "center",
  previewer = false,
  results_title = false,
  sorting_strategy = "ascending",
  theme = "dropdown",
  winblend = 10
}

--]]
