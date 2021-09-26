vim.opt.listchars = {eol = '↲', tab = '▸ ', trail = '·'}

vim.g.mapleader = ' '

local map = vim.api.nvim_set_keymap

map('n', '<Leader>w', ':write<CR>', {noremap = true})
map('n', '<Leader>q', ':q<CR>', {noremap = true})
map('n', '<Leader>f', ':Telescope find_files<CR>', {noremap = true})

