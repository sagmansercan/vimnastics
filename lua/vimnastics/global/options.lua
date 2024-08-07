vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fileencoding = 'utf-8'
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99 -- no fold by default
vim.opt.guicursor = ''
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'nosplit'
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 20
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.showtabline = 1
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.timeoutlen = 1000
vim.opt.wrap = true
vim.opt.writebackup = false

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
vim.keymap.set('n', '<leader>q', '<cmd>:qa<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>s', '/', { desc = 'Search raw' })
vim.keymap.set('n', '<leader>n', '/<C-r>+<CR>', { desc = 'Search text from clipboard' })
vim.keymap.set('n', '-', '*', { desc = 'Search current word' })
vim.keymap.set('v', '<leader>n', 'y/<C-r>"<CR>', { desc = 'Search current word' })
vim.keymap.set('n', '<leader>gl', '<cmd>Glow<CR>', { desc = 'Glow markdown' })
vim.keymap.set('n', '<leader>eb', '<cmd>Git blame<CR>', { desc = 'Open all lines git blame' })
vim.keymap.set('n', '<leader>er', '<cmd>GBrowse<CR>', { desc = 'Git browse' })
vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle<CR>', { desc = 'Undo tree toggle' })
vim.keymap.set('v', '<leader>ec', '<cmd>ExplainCode<CR>', { desc = 'Explain code via llama' })
vim.keymap.set('n', '<F1>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
vim.keymap.set('t', '<F1>', '<C-\\><C-n>:ToggleTerm<CR>', { desc = 'Toggle terminal in terminal mode' })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right' })
