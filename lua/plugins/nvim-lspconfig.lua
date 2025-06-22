local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")

	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.stdpath("config") .. "/lua",
					},
				},
			},
		},
	})

	-- Prisma
	lspconfig.prismals.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "prisma" },
		root_dir = lspconfig.util.root_pattern("schema.prisma", ".git"),
	})

	local ok, mason_registry = pcall(require, "mason-registry")
	if not ok then
		vim.notify("mason-registry could not be loaded")
		return
	end
	local angularls_path = mason_registry.get_package("angular-language-server"):get_install_path()
	local cmd = {
		"ngserver",
		"--stdio",
		"--tsProbeLocations",
		table.concat({
			angularls_path,
			vim.uv.cwd(),
		}, ","),
		"--ngProbeLocations",
		table.concat({
			angularls_path .. "/node_modules/@angular/language-server",
			vim.uv.cwd(),
		}, ","),
	}
	-- Angular
	lspconfig.angularls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
		root_dir = lspconfig.util.root_pattern("angular.json", "project.json", ".git"),
	-- css
	lspconfig.cssls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- HTML
	lspconfig.html.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- json
	lspconfig.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "json", "jsonc" },
	})

	-- python
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	-- bash
	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "sh" },
	})

	-- solidity
	lspconfig.solidity.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "solidity" },
	})

	-- html, typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
	lspconfig.emmet_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"html",
			"typescriptreact",
			"javascriptreact",
			"javascript",
			"typescript",
			"css",
			"sass",
			"scss",
			"json",
			"lua",
			"less",
			"svelte",
			"vue",
		},
	})

	lspconfig.ts_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"typescript",
			"typescriptreact", -- For TSX files
			"javascript",
			"javascriptreact", -- For JSX files
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
	})

	-- docker
	lspconfig.dockerls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettier = require("efmls-configs.formatters.prettier")
	local prettierd = require("efmls-configs.formatters.prettier_d")
	local fixjson = require("efmls-configs.formatters.fixjson")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local hadolint = require("efmls-configs.linters.hadolint")
	local solhint = require("efmls-configs.linters.solhint")

	-- configure efm server
	lspconfig.efm.setup({
		root_dir = lspconfig.util.root_pattern(".git/", "."),
		filetypes = {
			"lua",
			"python",
			"json",
			"jsonc",
			"sh",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
			"vue",
			"markdown",
			"docker",
			"solidity",
			"html",
			"css",
      "scss"
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
<<<<<<< HEAD
				python = { black },
				typescript = { eslint_d, prettierd },
=======
				python = { flake8, black },
				typescript = { eslint_d, prettier },
>>>>>>> e9951739632c5270bfa3adfaa61e9e046c4d067e
				json = { prettierd },
				jsonc = { eslint_d, fixjson },
				sh = { shellcheck, shfmt },
				javascript = { eslint_d, prettier },
				javascriptreact = { eslint_d, prettier },
				typescriptreact = { eslint_d, prettier },
				svelte = { eslint_d, prettierd },
				vue = { eslint_d, prettierd },
				markdown = { prettierd },
				docker = { hadolint, prettierd },
				solidity = { solhint },
<<<<<<< HEAD
				html = { prettierd },
				css = { prettierd },
				scss = { prettierd },
=======
				html = { prettier },
				css = { prettier },
>>>>>>> e9951739632c5270bfa3adfaa61e9e046c4d067e
				prisma = { prettier },
			},
		},
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
