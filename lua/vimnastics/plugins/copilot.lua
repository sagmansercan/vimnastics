-- -- Create an autocmd group for Copilot
-- vim.api.nvim_create_augroup('CopilotConfig', { clear = true })
--
-- vim.api.nvim_create_autocmd('InsertLeave', {
--     group = 'CopilotConfig',
--     pattern = '*',
--     callback = function()
--         -- Check if the current buffer is a 'dap-repl' buffer
--         local buftype = vim.api.nvim_get_option_value('buftype', { buf = 0 })
--         if buftype ~= 'prompt' then
--             -- It's safe to disable Copilot here
--             vim.cmd 'Copilot disable'
--         end
--     end,
-- })
--
-- vim.api.nvim_create_autocmd('InsertEnter', {
--     group = 'CopilotConfig',
--     pattern = '*',
--     callback = function()
--         -- Check if the current buffer is a 'dap-repl' buffer
--         local buftype = vim.api.nvim_get_option_value('buftype', { buf = 0 })
--         if buftype ~= 'prompt' then
--             -- It's safe to enable Copilot here
--             vim.cmd 'Copilot enable'
--         end
--     end,
-- })

-- Here a different copilot plugin is used, becuase the original one is not working.
-- The original plugin is: github.com/copilot.vim
-- Below is the failure message from the original plugin:
--      Error detected while processing function copilot#agent#LspHandle[4]..<SNR>42_OnMessage[8]..<SNR>42_DispatchMessage[2]..copilot#handlers#window_logMessage[1]..copilot#logger#Raw:
--      line   13:
--      E94: No matching buffer for copilot:///log

return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    dependencies = {
        {
            'zbirenbaum/copilot-cmp',
            config = function()
                require('copilot_cmp').setup()
            end,
        },
    },
    opts = {
        panel = {
            enabled = false,
            auto_refresh = false,
            keymap = {
                jump_prev = '[[',
                jump_next = ']]',
                accept = '<CR>',
                refresh = 'gr',
                open = '<M-CR>',
            },
            layout = {
                position = 'bottom', -- | top | left | right
                ratio = 0.4,
            },
        },
        suggestion = {
            enabled = false,
            auto_trigger = true,
            debounce = 50,
            keymap = {
                accept = '<C-e>',
                accept_word = false,
                accept_line = false,
                next = '<M-n>',
                prev = '<M-p>',
                dismiss = '<M-d>',
            },
        },
        filetypes = {
            lua = true,
            java = true,
            python = true,
            yaml = true,
            markdown = true,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            -- ['.'] = false,
            ['*'] = false,
        },
        copilot_node_command = 'node',
        server_opts_overrides = {
            -- trace = 'verbose',
            settings = {
                -- advanced = {
                --     listCount = 10, -- #completions for panel
                --     inlineSuggestCount = 3, -- #completions for getCompletions
                -- },
            },
        },
    },
    config = function(_, opts)
        require('copilot').setup(opts)
    end,
}
