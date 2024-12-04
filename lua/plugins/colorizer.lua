return {
	"norcalli/nvim-colorizer.lua",
  lazy=false,
	config = function()
		require("colorizer").setup({
      "css";
      "javascript";
      "typescript";
      "javascriptreact";
      "typescriptreact";
		})
	end,
}
