local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("config.globals")
require("config.options")
require("config.keymaps")
require("config.autocmds")

local opts = {
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "nordic" },
	},
	rtp = {
		disabled_plugins = {
			"gzip",
			"matchit",
			"matchparen",
			"netrwPlugin",
			"tarPlugin",
			"tohtml",
			-- "tutor",
			"zipPlugin",
			"netrw",
		},
	},
	change_detection = {
		notify = true,
	},
}
if vim.g.neovide then
	-- Helper function for transparency formatting
	local alpha = function()
		return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_transparency = 1
	vim.g.transparency = 1
	vim.g.neovide_background_color = "#0f1117" .. alpha()
	vim.g.neovide_padding_top = 10
	vim.g.guifont = { ":20" }
end

vim.g.indent_blankline_filetype_exclude = { "dashboard" }

require("lazy").setup("plugins", opts)
