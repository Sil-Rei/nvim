-- lazy.nvim
local config = {
  openai_api_key = "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",
}

return {
	"robitx/gp.nvim",
  lazy = false,
	config = function()
		require("gp").setup(config)

		-- or setup with your own config (see Install > Configuration in Readme)
		-- require("gp").setup(config)

        	-- shortcuts might be setup here (see Usage > Shortcuts in Readme)
	end,
}
