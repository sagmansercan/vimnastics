M = {}

local function set_keymap(mode, key, action, opts)
    vim.api.nvim_set_keymap(mode, key, action, opts)
end

-- local map_opts = { noremap = true, silent = true }
local map_opts = { noremap = true, silent = true }

local only_letter_mappings = {
    -- → Letters are all(a-z, A-Z) reserved for normal mode, so do not use them in normal mode except for special cases like g and K
    -- → Numbers are all(0-9) reserved for normal mode, so do not use them

    -- Easy exit from insert mode - [experimental]
    {
        key = 'jj',
        map = {
            { mode = 'i', action = '<C-c>', opts = { desc = 'Exit insert mode' } },
        },
    },
    {
        key = 'kk',
        map = {
            { mode = 'i', action = '<C-c>', opts = { desc = 'Exit insert mode' } },
        },
    },

    -- LSP
    {
        key = 'gd',
        map = {
            { mode = 'n', action = '<cmd>lua vim.lsp.buf.definition()<CR>', opts = { desc = 'Go to definition' } },
        },
        plugin = 'lspconfig',
    },
    {
        key = 'gD',
        map = {
            { mode = 'n', action = '<cmd>lua vim.lsp.buf.declaration()<CR>', opts = { desc = 'Go to declaration' } },
        },
        plugin = 'lspconfig',
    },
    {
        key = 'gr',
        map = {
            { mode = 'n', action = '<cmd>lua vim.lsp.buf.references()<CR>', opts = { desc = 'Go to references' } },
        },
        plugin = 'lspconfig',
    },
    {
        key = 'gi',
        map = {
            { mode = 'n', action = '<cmd>lua vim.lsp.buf.implementation()<CR>', opts = { desc = 'Go to implementation' } },
        },
        plugin = 'lspconfig',
    },
    {
        key = 'K',
        map = {
            { mode = 'n', action = '<cmd>lua vim.lsp.buf.hover()<CR>', opts = { desc = 'Show hover' } },
        },
        plugin = 'lspconfig',
    },
    {
        key = 'gR',
        map = {
            { mode = 'n', action = '<cmd>lua vim.lsp.buf.rename()<CR>', opts = { desc = 'Rename' } },
        },
        plugin = 'lspconfig',
    },
    {
        key = 'gC',
        map = {
            { mode = 'n', action = '<cmd>lua vim.lsp.buf.code_action()<CR>', opts = { desc = 'Code action' } },
        },
        plugin = 'lspconfig',
    },
}
local special_keys_mappings = {
    {
        key = '<ESC>',
        map = {
            { mode = 'n', action = '<C-c><cmd>nohl<CR>', opts = { desc = 'Clear search highlight' } },
            { mode = 't', action = '<C-\\><C-n>', opts = { desc = 'Exit terminal mode' } },
        },
    },

    -- Arrow keys → Disable navigation via arrow keys in normal mode, use `hjkl` instead
    {
        key = '<left>',
        map = {
            { mode = 'n', action = '', opts = { desc = 'Disable navigation via arrow keys' } },
        },
    },
    {
        key = '<right>',
        map = {
            { mode = 'n', action = '', opts = { desc = 'Disable navigation via arrow keys' } },
        },
    },
    {
        key = '<up>',
        map = {
            { mode = 'n', action = '', opts = { desc = 'Disable navigation via arrow keys' } },
        },
    },
    {
        key = '<down>',
        map = {
            { mode = 'n', action = '', opts = { desc = 'Disable navigation via arrow keys' } },
        },
    },

    -- `<` and `>` -> continous indenting
    {
        key = '<',
        map = {
            { mode = 'v', action = '<gv', opts = { desc = 'Indent left' } },
        },
    },
    {
        key = '>',
        map = {
            { mode = 'v', action = '>gv', opts = { desc = 'Indent right' } },
        },
    },

    -- Arrow keys → Disable navigation via arrow keys in normal mode, use `hjkl` instead
    {
        key = '<left>',
        map = {
            { mode = 'n', action = '', opts = { desc = 'Disable navigation via arrow keys' } },
        },
    },
    {
        key = '<right>',
        map = {
            { mode = 'n', action = '', opts = { desc = 'Disable navigation via arrow keys' } },
        },
    },
    {
        key = '<up>',
        map = {
            { mode = 'n', action = '', opts = { desc = 'Disable navigation via arrow keys' } },
        },
    },
    {
        key = '<down>',
        map = {
            { mode = 'n', action = '', opts = { desc = 'Disable navigation via arrow keys' } },
        },
    },

    -- `<` and `>` -> continous indenting
    {
        key = '<',
        map = {
            { mode = 'v', action = '<gv', opts = { desc = 'Indent left' } },
        },
    },
    {
        key = '>',
        map = {
            { mode = 'v', action = '>gv', opts = { desc = 'Indent right' } },
        },
    },
}
local function_keys_mappings = {
    -- Function keys
    {
        key = '<F1>',
        map = {
            { mode = 'n', action = '<cmd>ToggleTerm<CR>', opts = { desc = 'Toggle terminal' } },
            { mode = 't', action = '<C-\\><C-n>:ToggleTerm<CR>', opts = { desc = 'Toggle terminal in terminal mode' } },
        },
    },
    -- F2 →
    -- F3 →
    -- F4 →
    {
        key = '<F5>',
        map = {
            { mode = 'n', action = '<cmd>lua require("dap").continue()<CR>', opts = { desc = 'Debug: Start/Continue' } },
        },
    },
    {
        key = '<F6>',
        map = {
            { mode = 'n', action = '<cmd>lua require("dap").close()<CR>', opts = { desc = 'Debug: Close' } },
        },
    },
    {
        key = '<F7>',
        map = {
            { mode = 'n', action = '<cmd>lua require("dap").toggle_breakpoint()<CR>', opts = { desc = 'Debug: Toggle Breakpoint' } },
        },
    },
    {
        key = '<F8>',
        map = {
            {
                mode = 'n',
                action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')<CR>",
                opts = { desc = 'Debug: Conditional Breakpoint' },
            },
        },
    },
    {
        key = '<F9>',
        map = {
            { mode = 'n', action = '<cmd>lua require("dap").repl.toggle()<CR>', opts = { desc = 'Debug: REPL toggle' } },
        },
    },
    {
        key = '<F10>',
        map = {
            { mode = 'n', action = '<cmd>lua require("dap").step_over()<CR>', opts = { desc = 'Debug: Step Over' } },
        },
    },
    {
        key = '<F11>',
        map = {
            { mode = 'n', action = '<cmd>lua require("dap").step_into()<CR>', opts = { desc = 'Debug: Step Into' } },
        },
    },
    {
        key = '<F12>',
        map = {
            { mode = 'n', action = '<cmd>lua require("dap").step_out()<CR>', opts = { desc = 'Debug: Step Out' } },
        },
    },
}
local cmd_keys_mappings = {
    -- Cmd(Ctrl)
    -- `C` is for Ctrl, but here all the keymaps are set according to Cmd key on Mac. Hexapped in iterm2 config.
    -- C-a → reserved for tmux prefix
    {
        key = '<C-b>',
        map = {
            { mode = 'n', action = '<cmd>Telescope buffers<CR>', opts = { desc = 'Buffers' } },
        },
        plugin = 'telescope',
    },
    -- C-c → reserved for canceling operations
    -- C-d → reserved for scrolling down
    {
        key = '<C-e>',
        map = {
            { mode = 'n', action = 'ggVG', opts = { desc = 'Select all' } },
            { mode = 'v', action = '<C-c>ggVG', opts = { desc = 'Select all' } },
        },
    },
    {
        key = '<C-f>',
        map = {
            { mode = 'n', action = '/', opts = { desc = 'Search text in current buffer', silent = false } },
        },
    },
    {
        key = '<C-g>',
        map = {
            { mode = 'n', action = '<cmd>Telescope git_files<CR>', opts = { desc = 'Git files' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<C-g>',
        map = {
            {
                mode = 'i',
                action = function()
                    return require('cmp').mapping.complete()
                end,
                opts = { desc = 'Trigger completion' },
            },
        },
        plugin = 'cmp',
    },
    -- C-h → reserved for window/tmux navigation
    -- C-i → reserved for navigating to next cursor position
    -- C-j → reserved for window/tmux navigation
    -- C-k → reserved for window/tmux navigation
    -- C-l → reserved for window/tmux navigation
    -- C-m → reserved for Enter
    {
        key = '<C-n>',
        map = {
            { mode = 'n', action = '<cmd>bn<CR>', opts = { desc = 'Next buffer' } },
        },
    },
    {
        key = '<C-n>',
        map = {
            {
                mode = 'i',
                action = function()
                    return require('cmp').mapping.select_next_item()
                end,
                opts = { desc = 'Completion select next item' },
            },
        },
        plugin = 'cmp',
    },
    -- C-o → reserved for jumping back and forth in navigation history
    {
        key = '<C-p>',
        map = {
            { mode = 'n', action = '<cmd>bp<CR>', opts = { desc = 'Previous buffer' } },
        },
    },
    {
        key = '<C-p>',
        map = {
            {
                mode = 'i',
                action = function()
                    return require('cmp').mapping.select_previous_item
                end,
                opts = { desc = 'Completion select previous item' },
            },
        },
        plugin = 'cmp',
    },
    -- C-q → reserved for quitting
    -- C-r → reserved for redo
    {
        key = '<C-s>',
        map = {
            { mode = 'n', action = '<cmd>w<CR>', opts = { desc = 'Save changes' } },
            { mode = 'i', action = '<C-c><cmd>w<CR>', opts = { desc = 'Save changes' } },
        },
    },
    -- C-t → reserved for tagstack operations
    -- C-u → reserved for page navigation
    -- C-v → reserved for paste
    -- C-w → reserved for closing windows
    {
        key = '<C-x>',
        map = {
            { mode = 'n', action = '<cmd>bdelete<CR>', opts = { desc = 'Close buffer' } },
        },
    },
    {
        key = '<C-y>',
        map = {
            { mode = 'n', action = '<cmd>Telescope live_grep<CR>', opts = { desc = 'Live grep' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<C-y>',
        map = {
            {
                mode = 'i',
                action = function()
                    return require('cmp').mapping.confirm { select = true }
                end,
                opts = { desc = 'Completion selection' },
            },
        },
        plugin = 'cmp',
    },
    -- C-z → reserved for suspending neovim process and go back to shell which current neovim instance is opened
}
local leader_keys_mappings = {
    -- Leader
    -- leader-a
    -- leader-b
    -- leader-c
    -- leader-d → Trouble(diagnostics)
    {
        key = '<leader>dc',
        map = {
            { mode = 'n', action = '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', opts = { desc = 'Toggle document diagnostics' } },
        },
        plugin = 'trouble',
    },
    {
        key = '<leader>dw',
        map = {
            { mode = 'n', action = '<cmd>Trouble diagnostics toggle<CR>', opts = { desc = 'Workspace diagnostics' } },
        },
        plugin = 'trouble',
    },
    -- leader-e
    -- leader-f
    -- leader-g
    -- leader-h
    -- leader-i
    -- leader-j
    -- leader-k
    -- leader-l
    -- leader-m
    -- leader-n
    -- leader-o
    -- leader-p
    -- leader-q
    -- leader-r
    -- leader-s
    -- leader-t → Telescope
    {
        key = '<leader>ta',
        map = {
            { mode = 'n', action = '<cmd>Telescope autocommands<CR>', opts = { desc = 'Autocommands' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tb',
        map = {
            { mode = 'n', action = '<cmd>Telescope buffers<CR>', opts = { desc = 'Buffers' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tc',
        map = {
            { mode = 'n', action = '<cmd>Telescope current_buffer_fuzzy_find<CR>', opts = { desc = 'Code actions' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tdf',
        map = {
            { mode = 'n', action = '<cmd>Telescope lsp_definitions<CR>', opts = { desc = 'LSP Definitions' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tdi',
        map = {
            { mode = 'n', action = '<cmd>Telescope diagnostics<CR>', opts = { desc = 'Diagnostics' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>te',
        map = {
            { mode = 'n', action = '<cmd>Telescope file_browser<CR>', opts = { desc = 'File browser' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tf',
        map = {
            { mode = 'n', action = '<cmd>Telescope find_files<CR>', opts = { desc = 'Find files' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tgf',
        map = {
            { mode = 'n', action = '<cmd>Telescope git_files<CR>', opts = { desc = 'Git files' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tgs',
        map = {
            { mode = 'n', action = '<cmd>Telescope git_status<CR>', opts = { desc = 'Git status' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>th',
        map = {
            { mode = 'n', action = '<cmd>Telescope help_tags<CR>', opts = { desc = 'Help tags' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>ti',
        map = {
            { mode = 'n', action = '<cmd>Telescope lsp_implementations<CR>', opts = { desc = 'LSP Implementations' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tj',
        map = {
            { mode = 'n', action = '<cmd>Telescope jumplist<CR>', opts = { desc = 'Jumplist' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tk',
        map = {
            { mode = 'n', action = '<cmd>Telescope keymaps<CR>', opts = { desc = 'Keymaps' } },
        },
    },
    {
        key = '<leader>tl',
        map = {
            { mode = 'n', action = '<cmd>Telescope live_grep<CR>', opts = { desc = 'Live grep' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tm',
        map = {
            { mode = 'n', action = '<cmd>Telescope marks<CR>', opts = { desc = 'Marks' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tn',
        map = {
            { mode = 'n', action = '<cmd>Telescope notify<CR>', opts = { desc = 'Notify' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>to',
        map = {
            { mode = 'n', action = '<cmd>Telescope oldfiles<CR>', opts = { desc = 'Old files' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tq',
        map = {
            { mode = 'n', action = '<cmd>Telescope quickfix<CR>', opts = { desc = 'Quickfix' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tr',
        map = {
            { mode = 'n', action = '<cmd>Telescope lsp_references<CR>', opts = { desc = 'References' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>ts',
        map = {
            { mode = 'n', action = '<cmd>Telescope lsp_document_symbols<CR>', opts = { desc = 'Document symbols' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tt',
        map = {
            { mode = 'n', action = '<cmd>Telescope treesitter<CR>', opts = { desc = 'Treesitter' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tv',
        map = {
            { mode = 'n', action = '<cmd>Telescope vim_options<CR>', opts = { desc = 'Vim commands' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tz',
        map = {
            { mode = 'n', action = '<cmd>Telescope search_history<CR>', opts = { desc = 'Search history' } },
        },
        plugin = 'telescope',
    },
    {
        key = '<leader>tw',
        map = {
            { mode = 'n', action = '<cmd>Telescope grep_string<CR>', opts = { desc = 'Grep string = current word' } },
        },
        plugin = 'telescope',
    },
    -- leader-u
    -- leader-v
    -- leader-w
    -- leader-x
    -- leader-y
    -- leader-z
    -- leader-0
    -- leader-1
    -- leader-2
    -- leader-3
    -- leader-4
    -- leader-5
    -- leader-6
    -- leader-7
    -- leader-8
    -- leader-9
    -- leader-!
    -- leader-@
    -- leader-#
    -- leader-$
    -- leader-%
    -- leader-^
    -- leader-*
    -- leader-(
    -- leader-)
    -- leader-_
    -- leader-+
    -- leader-=
    -- leader-`
    -- leader-~
    -- leader-[
    -- leader-]
    -- leader-{
    -- leader-}
    -- leader-|
    -- leader-;
    -- leader-:
    -- leader-'
    -- leader-"
    -- leader-,
    -- leader-.
    -- leader-<
    -- leader->
    -- leader-/
    -- leader-?
    -- leader-\
    -- leader-`
    {
        key = "<leader>'",
        map = {
            { mode = 'n', action = '<cmd>Telescope marks<CR>', opts = { desc = 'Marks' } },
        },
        plugin = 'telescope',
    },
}

local mappings = {}
for _, mapping in ipairs(only_letter_mappings) do
    table.insert(mappings, mapping)
end
for _, mapping in ipairs(special_keys_mappings) do
    table.insert(mappings, mapping)
end
for _, mapping in ipairs(function_keys_mappings) do
    table.insert(mappings, mapping)
end
for _, mapping in ipairs(cmd_keys_mappings) do
    table.insert(mappings, mapping)
end
for _, mapping in ipairs(leader_keys_mappings) do
    table.insert(mappings, mapping)
end

local cmp_keymap = {}
local dap_setters = {}
local lsp_setters = {}
local telescope_setters = {}
local trouble_setters = {}

for _, mapping in ipairs(mappings) do
    for _, map in ipairs(mapping.map) do
        local opts = vim.tbl_extend('force', map_opts, map.opts)
        if not mapping.plugin then
            -- set builtin keymaps directly
            set_keymap(map.mode, mapping.key, map.action, opts)
        else
            if mapping.plugin == 'cmp' then
                -- collect all cmp keymap setters to be called after cmp is loaded
                -- See set_cmp_keymaps function below and completion.lua
                cmp_keymap[mapping.key] = map.action
            elseif mapping.plugin == 'dap' then
                -- collect all dap keymap setters to be called after dap is loaded
                -- See set_dap_keymaps function below and dap.lua
                table.insert(dap_setters, function()
                    set_keymap(map.mode, mapping.key, map.action, opts)
                end)
            elseif mapping.plugin == 'lspconfig' then
                -- collect all lsp keymap setters to be called after lspconfig is loaded
                -- See set_lsp_keymaps function below and lsp.lua
                table.insert(lsp_setters, function()
                    set_keymap(map.mode, mapping.key, map.action, opts)
                end)
            elseif mapping.plugin == 'telescope' then
                -- collect all telescope keymap setters to be called after telescope is loaded
                -- See set_telescope_keymaps function below and telescope.lua
                table.insert(telescope_setters, function()
                    set_keymap(map.mode, mapping.key, map.action, opts)
                end)
            elseif mapping.plugin == 'trouble' then
                -- collect all trouble keymap setters to be called after trouble is loaded
                -- See set_trouble_keymaps function below and trouble.lua
                table.insert(trouble_setters, function()
                    set_keymap(map.mode, mapping.key, map.action, opts)
                end)
            else
                vim.notify('Unknown plugin: ' .. mapping.plugin)
            end
        end
    end
end

-- this method is expected to be called after telescope is loaded.
-- See telescope.lua
M.set_telescope_keymaps = function()
    for _, setter in ipairs(telescope_setters) do
        setter()
    end
end

M.set_trouble_keymaps = function()
    for _, setter in ipairs(trouble_setters) do
        setter()
    end
end

M.set_lsp_keymaps = function()
    for _, setter in ipairs(lsp_setters) do
        setter()
    end
end

M.set_cmp_keymaps = function()
    local tbl = {}
    for key, cmp_func in pairs(cmp_keymap) do
        tbl[key] = cmp_func()
    end
    return require('cmp').mapping.preset.insert(tbl)
end

M.set_dap_keymaps = function()
    for _, setter in ipairs(dap_setters) do
        setter()
    end
end

return M
