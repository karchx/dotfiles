vim.g.mapleader = ' '
vim.opt.listchars = {eol = '↲', tab = '▸ ', trail = '·'}

local set = vim.opt

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

-- Rainbow
vim.cmd [[
  augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
  augroup END

  autocmd FileType * RainbowParentheses
]]

vim.g['rainbow#max_level'] = 16

-- vim.g['rainbow#pairs'] = { { "(', ')" }, { "[', ']" }, { "{', '}" }}


-- List of colors that you do not want. ANSI code or #RRGGBB
vim.g['rainbow#blacklist']= {233, 234}

vim.g['coc_node_path'] = '/home/stivarch/.nvm/versions/node/v16.3.0/bin/node'
