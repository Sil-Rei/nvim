return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	lazy = false,
	config = function()
		local hooks = require("ibl.hooks")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a313f" })
			vim.api.nvim_set_hl(0, "IblScope", { fg = "#4A566C" })
		end)

		hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
		hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)

		require("ibl").setup({
			indent = { highlight = "IblIndent" },
			scope = { enabled = true, highlight = "IblScope" },
		})
	end,
}
