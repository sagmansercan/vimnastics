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

        keymaps.set_dap_keymaps()

        vim.fn.sign_define('DapBreakpoint', { text = '🚩' })
        vim.fn.sign_define('DapStopped', { text = '🟡' })
    end,
}
