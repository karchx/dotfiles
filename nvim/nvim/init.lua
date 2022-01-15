if vim.g.vscode then
	return
end


if require("first_load")() then
	return
end

require("impatient")

vim.g.mapleader = " "

require("plugins")
require("keymaps")
require("settings")
