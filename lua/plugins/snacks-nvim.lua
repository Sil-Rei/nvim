return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		notifier = { enabled = true },
		quickfile = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{
					section = "terminal",
					cmd = "chafa ~/.config/nvim/forrest.jpg --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
					height = 17,
					padding = 1,
				},
				{
					pane = 2,
					{ section = "keys", gap = 1, padding = 1 },
				},
			},
		},
	},
}
