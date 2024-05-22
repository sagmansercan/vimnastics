vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.autoread = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.cursorline = true
vim.opt.debug = 'msg'
vim.opt.expandtab = true
vim.opt.fileencoding = 'utf-8'
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 4
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 20
vim.opt.showmode = false
vim.opt.showtabline = 1
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 1000
vim.opt.wrap = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set({ 'i', 'n' }, '<C-s>', '<cmd>w<CR><ESC>', { desc = 'Save current buffer' })
vim.keymap.set('n', '<left>', '')
vim.keymap.set('n', '<right>', '')
vim.keymap.set('n', '<up>', '')
vim.keymap.set('n', '<down>', '')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'delete current buffer' })
vim.keymap.set('n', '<leader>bD', '<cmd>bd!<CR>', { desc = 'force delete current buffer' })
vim.keymap.set('n', '<leader>be', '<cmd>%bd|e#|bd#<CR>', { desc = 'Delete all buffers except current' })
vim.keymap.set('n', '<C-e>', 'ggVG', { desc = 'Select all' })
vim.keymap.set('n', '<leader>w', '<cmd>:q<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<C-f>', '/', { desc = 'Search raw' })
