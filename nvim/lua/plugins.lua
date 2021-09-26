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
  use 'tanvirtin/monokai.nvim' -- Monokai Theme
  use 'ryanoasis/vim-devicons' -- Icons
  use {'neoclide/coc.nvim', branch = 'release'}
end)
