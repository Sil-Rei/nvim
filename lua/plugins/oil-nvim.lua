return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optionale Abhängigkeiten
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"lewis6991/gitsigns.nvim",
	},
	lazy = false,
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, bufnr)
					return name == ".." or name == ".git"
				end,
			},
      columns = {
        "icon",
        {
          "git_status",
          highlight = "DiagnosticSignHint",
        },
      },
		})
	end,
}
