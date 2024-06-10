return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = function()
		require("nvim-tree").setup({
			filters = {
				dotfiles = false,
			},
     actions = {
      --   open_file = {
      --     resize_window = false,
      --   }
      },
      view = {adaptive_size = true}

		})
	end,
}
