return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme catppuccin-macchiato")
		-- Hinzufügen der Integrationseinstellungen
		require("catppuccin").setup({
			integrations = {
				nvimtree = true,
				cmp = true,
				treesitter = true,
				indent_blankline = {
					enabled = true,
					scope_color = "macchiato", -- catppuccin color (eg. `lavender`) Default: text
					colored_indent_levels = true,
				},
				telescope = {
					enabled = true,
					-- style = "nvchad"
				},
				illuminate = {
					enabled = true,
					lsp = true,
				},
        which_key = true,
			},
		})
	end,
}
