vim.g.mapleader = " "

vim.keymap.set("n", "<leader>f", "<cmd>Prettier<cr>")
vim.keymap.set("n", "<leader>tc", "<cmd>TSContext toogle<cr>")
vim.keymap.set("n", "oo", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
