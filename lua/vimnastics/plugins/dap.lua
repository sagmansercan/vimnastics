return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'leoluz/nvim-dap-go',
        'LiadOz/nvim-dap-repl-highlights',
    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_installation = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'delve',
            },
        }

        require('nvim-dap-repl-highlights').setup()

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<F12>', dap.close, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Debug: Set Breakpoint' })
        vim.keymap.set('n', '<leader>do', dapui.open, { desc = 'DAPUI open' })
        vim.keymap.set('n', '<leader>dc', dapui.close, { desc = 'DAPUI Close' })
        vim.keymap.set('n', '<leader>dro', dap.repl.open, { desc = 'DAPrepl open' })
        vim.keymap.set('n', '<leader>drc', dap.repl.close, { desc = 'DAPrepl close' })
        vim.keymap.set('n', '<leader>drt', dap.repl.toggle, { desc = 'DAPrepl toggle' })

        vim.keymap.set('n', '<leader>djtc', '<cmd>JavaTestDebugCurrentClass<CR>', { desc = 'nvim-java: test current class' })
        vim.keymap.set('n', '<leader>djtm', '<cmd>JavaTestDebugCurrentMethod<CR>', { desc = 'nvim-java: test current method' })

        dap.configurations.scala = {
            {
                type = 'scala',
                request = 'launch',
                name = 'RunOrTest',
                metals = {
                    runType = 'runOrTestFile',
                    --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
                },
            },
            {
                type = 'scala',
                request = 'launch',
                name = 'Test Target',
                metals = {
                    runType = 'testTarget',
                },
            },
        }

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        }

        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

        -- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        vim.fn.sign_define('DapBreakpoint', { text = '🚩' })
        vim.fn.sign_define('DapStopped', { text = '🟡' })

        -- Install golang specific config
        require('dap-go').setup {
            delve = {
                -- On Windows delve must be run attached or it crashes.
                -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
                detached = vim.fn.has 'win32' == 0,
            },
        }
    end,
}
