return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	event = "BufReadPre",
	opts = {
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		}, 
	},
  config = function()
    require("mason").setup({
  registries = {
    "github:mason-org/mason-registry@2023-05-15-next-towel"
  }
    })
  end
}
