vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim' -- Package manager
	use {
  	'nvim-telescope/telescope.nvim',
  	requires = { {'nvim-lua/plenary.nvim'} }
	} -- Package Telescope

  use 'preservim/nerdtree' -- NERDTree
  use 'vim-airline/vim-airline' -- VIM airline
  use 'vim-airline/vim-airline-themes' -- airline theme
  use {'kaicataldo/material.vim', branch = 'main' } -- theme Material
  use 'ryanoasis/vim-devicons' -- Icons
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'prettier/vim-prettier' -- Prettier
  use 'junegunn/rainbow_parentheses.vim' -- Rainbow

  use 'pangloss/vim-javascript'
  use 'mxw/vim-jsx'

  use 'leafgarland/typescript-vim'
  use 'peitalin/vim-jsx-typescript'
end)
