local set_dap_config_python = function(dap)
    dap.adapters.python = function(cb, config)
        if config.request == 'attach' then
            local port = (config.connect or config).port
            local host = (config.connect or config).host or '127.0.0.1'
            cb {
                type = 'server',
                port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                host = host,
                options = {
                    source_filetype = 'python',
                },
            }
        else
            cb {
                type = 'executable',
                command = 'python',
                args = { '-m', 'debugpy.adapter' },
                options = {
                    source_filetype = 'python',
                },
            }
        end
    end

    dap.configurations.python = {
        {
            type = 'python',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            -- pythonPath = function()
            --     return vim.fn.exepath 'python3'
            -- end,
        },
    }
end

return {
    'mfussenegger/nvim-dap',
    -- dependencies = {
    --     'rcarriga/nvim-dap-ui',
    --     'nvim-neotest/nvim-nio',
    --     'jay-babu/mason-nvim-dap.nvim',
    --     'leoluz/nvim-dap-go',
    --     'LiadOz/nvim-dap-repl-highlights',
    -- },
    config = function()
        local dap = require 'dap'
        local keymaps = require 'vimnastics.global.keymaps'
        set_dap_config_python(dap)
        -- local dapui = require 'dapui'

        -- require('nvim-dap-repl-highlights').setup()

        -- -- Basic debugging keymaps, feel free to change to your liking!
        keymaps.set_dap_keymaps(dap)

        -- dap.configurations.scala = {
        --     {
        --         type = 'scala',
        --         request = 'launch',
        --         name = 'RunOrTest',
        --         metals = {
        --             runType = 'runOrTestFile',
        --             --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
        --         },
        --     },
        --     {
        --         type = 'scala',
        --         request = 'launch',
        --         name = 'Test Target',
        --         metals = {
        --             runType = 'testTarget',
        --         },
        --     },
        -- }

        -- -- Dap UI setup
        -- -- For more information, see |:help nvim-dap-ui|
        -- dapui.setup {
        --     icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        --     controls = {
        --         icons = {
        --             pause = '⏸',
        --             play = '▶',
        --             step_into = '⏎',
        --             step_over = '⏭',
        --             step_out = '⏮',
        --             step_back = 'b',
        --             run_last = '▶▶',
        --             terminate = '⏹',
        --             disconnect = '⏏',
        --         },
        --     },
        -- }

        -- -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        -- vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

        -- -- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

        vim.fn.sign_define('DapBreakpoint', { text = '🚩' })
        vim.fn.sign_define('DapStopped', { text = '🟡' })

        -- -- Install golang specific config
        -- require('dap-go').setup {
        --     delve = {
        --         -- On Windows delve must be run attached or it crashes.
        --         -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        --         detached = vim.fn.has 'win32' == 0,
        --     },
        -- }
    end,
}
