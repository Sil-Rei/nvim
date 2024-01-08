return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "hyper",
      hide ={
        tabline,
      }
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
