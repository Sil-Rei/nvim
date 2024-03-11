return {
	"glepnir/lspsaga.nvim",
	lazy = false,
	config = function()
		require("lspsaga").setup({
			-- keybinds for navigation in lspsaga window
			move_in_saga = { prev = "<C-k>", next = "<C-j>" },
			-- use enter to open file with finder
			finder_action_keys = {
				open = "<CR>",
			},
			-- use enter to open file with definition preview
			definition_action_keys = {
				edit = "<CR>",
			},
      lightbulb = {
        enable = false,
        enable_in_insert = false,
        sign = false,
        virtual_text = false,
        debounce = 10,
      },
      symbol_in_winbar = {
        enable = true,
        show_file = true,
      }
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
}
