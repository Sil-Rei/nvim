local config = function()
	local theme = "catppuccin"

	-- set bg transparency in all modes
	require("lualine").setup({
		options = {
			theme = theme,
			globalstatus = true,
		},
		tabline = {},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { "diagnostics" },
			lualine_x = { "encoding", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}
