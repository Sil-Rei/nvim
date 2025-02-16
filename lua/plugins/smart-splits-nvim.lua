return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	config = function()
		require("smart-splits").setup({
			default_amount = 3,
			at_edge = "wrap",
		})

		vim.keymap.set("n", "<A-h>", require("smart-splits").move_cursor_left, {noremap = true})
		vim.keymap.set("n", "<A-j>", require("smart-splits").move_cursor_down)
		vim.keymap.set("n", "<A-k>", require("smart-splits").move_cursor_up)
		vim.keymap.set("n", "<A-l>", require("smart-splits").move_cursor_right)

	end,
}
