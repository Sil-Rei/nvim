return {
	"hrsh7th/nvim-cmp",
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local types = require("cmp.types")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		require("luasnip/loaders/from_vscode").lazy_load()

		vim.opt.completeopt = "menu,menuone"

		-- Function to deprioritize snippets
		local function deprioritize_snippet(entry1, entry2)
			if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
				return false
			end
			if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
				return true
			end
		end

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp", priority=10}, -- lsp
				{ name = "luasnip"}, -- snippets
				{ name = "buffer"}, -- text within current buffer
				{ name = "path"}, -- file system paths
			}),
			-- configure lspkind for vs-code like icons
				formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
			sorting = {
				comparators = {
					deprioritize_snippet, -- Add the deprioritize function
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.kind,
					-- other comparators can be added here
				},
			},
		})

  cmp.setup.filetype("html", {
      sources = cmp.config.sources({
        {name = "nvim_lsp", priority=30},
        {name = "luasnip", priority=8},
      })
    })
	end,dependencies = {
		"onsails/lspkind.nvim",
		{

			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
	},
}
