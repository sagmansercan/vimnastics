local M = {}

M.pick_vertical = function(picker_fn)
    return function()
        picker_fn(require('telescope.themes').get_ivy {
            border = true,
            previewer = true,
            layout_strategy = 'vertical',
            layout_config = {
                -- width = 0.8,
                height = 0.9,
            },
            sorting_strategy = 'descending',
            -- line_width = 0.7,
            -- winblend = 10,
            -- results_title = false,
            -- preview_title = false,
        })
    end
end

return {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
        { 'nvim-telescope/telescope-file-browser.nvim' },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        -- { 'nvim-telescope/telescope-ui-select.nvim' },
        -- { 'nvim-telescope/telescope-dap.nvim' },
    },
    config = function()
        local keymaps = require 'vimnastics.global.keymaps'
        --         local actions = require 'telescope.actions'
        local filebrowser_actions = require 'telescope._extensions.file_browser.actions'
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
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                },
                find_command = { 'fd', '--type', 'f', '--hidden', '--smart-case', '--unrestricted' },
                layout_strategy = 'vertical',
            },
            pickers = {
                find_files = {},
                buffers = {
                    previewer = false,
                },
                current_buffer_fuzzy_find = {
                    previewer = false,
                },
                live_grep = {},
                lsp_implementations = {},
                lsp_references = {},
            },
            extensions = {
                file_browser = {
                    path = vim.loop.cwd(),
                    cwd = vim.loop.cwd(),
                    cwd_to_path = true,
                    grouped = false,
                    files = true,
                    add_dirs = true,
                    depth = 1,
                    auto_depth = false,
                    select_buffer = true,
                    hidden = { file_browser = true, folder_browser = true },
                    respect_gitignore = vim.fn.executable 'fd' == 1,
                    no_ignore = false,
                    follow_symlinks = false,
                    browse_files = require('telescope._extensions.file_browser.finders').browse_files,
                    browse_folders = require('telescope._extensions.file_browser.finders').browse_folders,
                    hide_parent_dir = true,
                    collapse_dirs = false,
                    prompt_path = true,
                    quiet = false,
                    dir_icon = '',
                    dir_icon_hl = 'Default',
                    display_stat = { date = true, size = true, mode = true },
                    hijack_netrw = true,
                    use_fd = true,
                    git_status = true,
                    mappings = {
                        ['i'] = {
                            ['<A-c>'] = filebrowser_actions.create,
                            ['<S-CR>'] = filebrowser_actions.create_from_prompt,
                            ['<A-r>'] = filebrowser_actions.rename,
                            ['<A-m>'] = filebrowser_actions.move,
                            ['<A-y>'] = filebrowser_actions.copy,
                            ['<A-d>'] = filebrowser_actions.remove,
                            ['<C-o>'] = filebrowser_actions.open,
                            ['<C-g>'] = filebrowser_actions.goto_parent_dir,
                            ['<C-e>'] = filebrowser_actions.goto_home_dir,
                            ['<C-w>'] = filebrowser_actions.goto_cwd,
                            ['<C-t>'] = filebrowser_actions.change_cwd,
                            ['<C-f>'] = filebrowser_actions.toggle_browser,
                            ['<C-h>'] = filebrowser_actions.toggle_hidden,
                            ['<C-s>'] = filebrowser_actions.toggle_all,
                            ['<bs>'] = filebrowser_actions.backspace,
                        },
                        ['n'] = {
                            ['c'] = filebrowser_actions.create,
                            ['r'] = filebrowser_actions.rename,
                            ['m'] = filebrowser_actions.move,
                            ['y'] = filebrowser_actions.copy,
                            ['d'] = filebrowser_actions.remove,
                            ['o'] = filebrowser_actions.open,
                            ['g'] = filebrowser_actions.goto_parent_dir,
                            ['e'] = filebrowser_actions.goto_home_dir,
                            ['w'] = filebrowser_actions.goto_cwd,
                            ['t'] = filebrowser_actions.change_cwd,
                            ['f'] = filebrowser_actions.toggle_browser,
                            ['h'] = filebrowser_actions.toggle_hidden,
                            ['s'] = filebrowser_actions.toggle_all,
                        },
                    },
                },
                -- ['ui-select'] = {
                --     require('telescope.themes').get_dropdown(),
                -- },
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    -- case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
            },
        }

        pcall(require('telescope').load_extension, 'file_browser')
        pcall(require('telescope').load_extension, 'fzf')
        -- pcall(require('telescope').load_extension, 'ui-select')
        -- pcall(require('telescope').load_extension, 'dap')
        keymaps.set_telescope_keymaps()
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
