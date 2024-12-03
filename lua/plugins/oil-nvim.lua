return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optionale Abhängigkeiten
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
				natural_order = true,
				is_always_hidden = function(name, _)
					return name == ".." or name == ".git"
				end,
			},
			columns = {
				"icon",
			},
      win_options = {
        number = false,          -- Normale Zeilennummern ausblenden
        relativenumber = false,  -- Relative Zeilennummern ausblenden
      },
		})

	end,
}
