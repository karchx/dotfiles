local map = function(key)
  -- extraer opciones
  local opts = {noremap=true}
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end

  -- soporte básico para atajos de buffer
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
  else
    vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
  end
end

map{'n', '<Leader>w', ':write<CR>'}
map{'n', '<Leader>q', ':quit<CR>'}
-- Telescope.nvim
map{'n', '<Leader>ff', ':Telescope find_files<CR>'}
map{'n', '<Leader>fg', ':Telescope live_grep<CR>'}
map{'n', '<Leader>fb', ':Telescope buffers<CR>'}
map{'n', '<Leader>fh', ':Telescope help_tags<CR>'}
--NERDTree
map{'n', '<Leader>b', ':NERDTreeToggle<CR>'}
map{'n', '<Leader>r', ':NERDTreeRefreshRoot<CR>'}

