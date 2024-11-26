require("stivarch.set")
require("stivarch.remap")
require("stivarch.lazy_init")

local augroup = vim.api.nvim_create_augroup
local StivarchGroup = augroup('StivarchGroup', {})
local format_sync_grp = augroup("GoFormat", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Clear blank space
autocmd({"BufWritePre"}, {
    group = StivarchGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Save and format
autocmd({"BufWritePre"}, {
    group = StivarchGroup,
    pattern = "*",
    command = "Prettier",
})

autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})
