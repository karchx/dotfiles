vim.g.mapleader = ' '

vim.cmd [[packadd packer.nvim]]

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

return require('packer').startup(function()
	use 'wbthomason/packer.nvim' -- Package manager
	use {
  	'nvim-telescope/telescope.nvim',
  	requires = { {'nvim-lua/plenary.nvim'} }
	} -- Package Telescope
end)
