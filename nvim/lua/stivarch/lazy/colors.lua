function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE" })
end

return {
    {
        "folke/tokyonight.nvim",
        config = function ()
            require('tokyonight').setup({
                transparent = true,
                styles = {
                   sidebars = "transparent",
                   floats = "transparent",
                }
            })
            ColorMyPencils("tokyonight-moon");
        end
    },
    -- {
    --     "rose-pine/neovim",
    --     name = "rose-pine",
    --     config = function()
    --         require('rose-pine').setup({
    --             disable_background = true,
    --             styles = {
    --                 italic = false,
    --             },
    --         })

    --         ColorMyPencils();
    --     end
    -- },


}
