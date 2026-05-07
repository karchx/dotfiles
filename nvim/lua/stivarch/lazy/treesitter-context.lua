return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "BufReadPost", -- No lo cargues al inicio (VimEnter), espera a leer un archivo
  opts = {
    enable = true,
    max_lines = 3,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20, -- Evita que bloques gigantes rompan la UI
    trim_scope = 'outer',
    mode = 'cursor',
    -- Esto es clave:
    separator = nil, 
  },
}
