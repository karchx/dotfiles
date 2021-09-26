vim.g.mapleader = ' '
local set = vim.opt

set.listchars = {eol = '↲', tab = '▸ ', trail = '·'}

set.number = true
set.mouse='a'
set.numberwidth=1
set.encoding='UTF-8'
set.sw=1
set.relativenumber=true
set.tabstop=2 
set.shiftwidth=2 

set.expandtab = true

-- Airline
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#left_sep'] = ' '
vim.g['airline#extensions#tabline#left_alt_sep'] = '|'
vim.g['airline_theme'] = 'base16_monokai'

-- Theme
require('monokai')
vim.cmd('colorscheme monokai')

vim.g['coc_node_path'] = '/home/stivarch/.nvm/versions/node/v16.3.0/bin/node'
