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
vim.g['airline_theme'] = 'material'

-- Theme
-- require('material')
vim.g['material_theme_style'] = 'darker'
vim.g['material_terminal_italics'] = 1
vim.cmd('colorscheme material')

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


-- Theme JS
vim.g['javascript_plugin_ngdoc'] = 1
vim.g['javascript_plugin_flow'] = 1

vim.cmd[[
    augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
    augroup END
]]

vim.g['javascript_conceal_function']             = "ƒ"
vim.g['javascript_conceal_null']                 = "ø"
vim.g['javascript_conceal_undefined']            = "¿"
vim.g['javascript_conceal_NaN']                  = "ℕ"
vim.g['javascript_conceal_prototype']            = "¶"
vim.g['javascript_conceal_static']               = "•"
vim.g['javascript_conceal_super']                = "Ω"
vim.g['javascript_conceal_arrow_function']       = "⇒"

set.conceallevel=1

--Enable vim-prettier to run in files without requiring the "@format" doc tag
vim.g['prettier#autoformat'] = 0
vim.g['prettier#config#tab_width'] = 4
vim.g['prettier#config#trailing_comma'] = 'es5'
vim.cmd[[
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.html Prettier
]]
