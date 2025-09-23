
return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	requires = { "nvim-tree/nvim-web-devicons", opt = true },

	config = function()
		local function fmt_mode(s)
			local mode_map = {
				["COMMAND"] = "COMMND",
				["V-BLOCK"] = "V-BLCK",
				["TERMINAL"] = "TERMNL",
				["V-REPLACE"] = "VREPLC",
				["O-PENDING"] = "0PNDNG",
			}
			return mode_map[s] or s
		end

		-- Theme-dependent custom colors.
		local text_hl = { fg = "#434C5E" }
		local icon_hl = { fg = "#4C566A" }
		local red = "#BF616A"

		local function get_recording_color()
			if vim.fn.reg_recording() ~= "" then
				return { fg = red }
			else
				return { fg = text_hl }
			end
		end

		local function diff_source()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end

		local telescope = {
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = fmt_mode,
						icon = { "" },
						separator = { right = " ", left = "" },
					},
				},
				lualine_b = {},
				lualine_c = {
					{
						function()
							return "Telescope"
						end,
						color = text_hl,
						icon = { "  ", color = icon_hl },
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {
					{
						"location",
						icon = { "", align = "left" },
					},
					{
						"progress",
						icon = { "", align = "left" },
						separator = { right = "", left = "" },
					},
				},
			},
			filetypes = { "TelescopePrompt" },
		}

		require("lualine").setup({
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = fmt_mode,
						icon = { "" },
						separator = { right = " ", left = "" },
					},
				},
				lualine_b = {},
				lualine_c = {
					{
						function()
							return vim.fn.reg_recording() ~= "" and "  " or ""
						end,
						color = get_recording_color,
						padding = 0,
						separator = "",
					},
					{
						"branch",
						color = text_hl,
						icon = { " ", color = icon_hl },
						separator = "",
						padding = 0,
					},
					{
						"diff",
						color = text_hl,
						icon = { "  ", color = text_hl },
						source = diff_source,
						symbols = {
							added = " ",
							modified = " ",
							removed = " ",
						},
						diff_color = {
							added = icon_hl,
							modified = icon_hl,
							removed = icon_hl,
						},
						padding = 0,
					},
				},
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = "󱤅 ",
							other = "󰠠 ",
						},
						colored = true,
						padding = 2,
					},
					{
						function()
							local buf_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
							if next(buf_clients) == nil then
								return "" 
							end
							local client_names = {}
							for _, client in pairs(buf_clients) do
								table.insert(client_names, client.name)
							end
							return table.concat(client_names, " ")
						end,
						padding = 1,
						color = text_hl,
						icon = { " ", color = icon_hl },
					},
				},
				lualine_y = {},
				lualine_z = {
					{
						"location",
						icon = { "", align = "left" },
					},
					{
						"progress",
						icon = { "", align = "left" },
						separator = { right = "", left = "" },
					},
				},
			},
			options = {
				globalstatus = true,
				section_separators = { left = " ", right = " " },
				component_separators = { left = "", right = "" },
			},
			extensions = {
				telescope,
			},
		})

	-- 	-- Ensure correct background for lualine.
	-- 	vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
	-- 		callback = function(_)
	-- 			require("lualine").setup({})
	-- 		end,
	-- 		pattern = { "*.*" },
	-- 		once = true,
	-- 	})
	end,
}

