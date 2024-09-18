return {
    'folke/trouble.nvim',
    branch = 'main',
    event = 'VeryLazy',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    config = function()
        local trouble = require 'trouble'
        trouble.setup {}
        local keymaps = require 'vimnastics.global.keymaps'
        keymaps.set_trouble_keymaps(trouble)
    end,
}
