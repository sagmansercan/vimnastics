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
                        -- ['<c-enter>'] = 'to_fuzzy_refine',
                        -- ['<ESC>'] = actions.close,
                        -- ['<Down>'] = actions.cycle_history_next,
                        -- ['<Up>'] = actions.cycle_history_prev,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        -- ['<C-s>'] = actions.cycle_previewers_next,
                        -- ['<C-a>'] = actions.cycle_previewers_prev,
                        -- ["<C-t>"] = trouble.open_with_trouble,
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
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>ss', function()
            --[[
        get_dropdown returned config ref
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
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 1,
                previewer = false,
                layout_config = {
                    width = 0.7,
                },
                sorting_strategy = 'descending',
            })
        end, { desc = '[/] Fuzzily search in current buffer' })
        vim.keymap.set(
            'n',
            '<leader>s/',
            function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end,
            { desc = '[S]earch [/] in Open Files' }
        )
        vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
    end,
}
