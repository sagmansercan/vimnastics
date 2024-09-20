return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = ' | ', right = ' | ' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                { 'branch', color = { fg = '#ffffff', bg = '#002813' } },
                { 'diff', color = { bg = '#000000' } },
                {
                    'diagnostics',
                    color = function()
                        local diagnostics_table = vim.diagnostic.get(vim.api.nvim_get_current_buf())
                        if not diagnostics_table then
                            return { bg = '#000000' }
                        end

                        for _, v in pairs(diagnostics_table) do
                            if v.severity == vim.diagnostic.severity.ERROR then
                                return { bg = '#ffffff' }
                            end
                        end
                        return { bg = '#000000' }
                    end,
                },
            },
            lualine_c = {
                {
                    'filename',
                    file_status = true, -- Displays file status (readonly status, modified status)
                    newfile_status = true, -- Display new file status (new file means no write after created)
                    path = 1, -- 0: Just the filename
                    -- 1: Relative path
                    -- 2: Absolute path
                    -- 3: Absolute path, with tilde as the home directory
                    -- 4: Filename and parent dir, with tilde as the home directory

                    shorting_target = 20, -- Shortens path to leave 40 spaces in the window
                    -- for other components.(terrible name, any suggestions?)
                    symbols = {
                        modified = '[+]', -- Text to show when the file is modified.
                        readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
                        unnamed = '[No Name]', -- Text to show for unnamed buffers.
                        newfile = '[New]', -- Text to show for newly created file before first write
                    },
                    color = function(_)
                        return { fg = vim.bo.modified and '#ffffff' or '#f5f1c0', bg = vim.bo.modified and '#3f4639' or '#071a10' }
                    end,
                    padding = 90,
                    icon = '📁',
                },
            },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    },
}
