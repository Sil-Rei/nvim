local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
  pcall(function()
    require("neoconf").setup({})
  end)

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Diagnostics: moderne Sign-Konfig
  local signs = {
    Error = diagnostic_signs.Error or "",
    Warn = diagnostic_signs.Warn or "",
    Hint = diagnostic_signs.Hint or "",
    Info = diagnostic_signs.Info or "",
  }
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = signs.Error,
        [vim.diagnostic.severity.WARN] = signs.Warn,
        [vim.diagnostic.severity.HINT] = signs.Hint,
        [vim.diagnostic.severity.INFO] = signs.Info,
      },
      numhl = false,
    },
  })

  -- Defaults für alle Server
  vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- lua_ls
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.stdpath("config") .. "/lua",
          },
        },
      },
    },
  })

  -- Prisma
  vim.lsp.config("prismals", {
    filetypes = { "prisma" },
    root_markers = { { "schema.prisma" }, ".git" },
  })

  -- Angular
  vim.lsp.config("angularls", {
    filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
    root_markers = { { "angular.json", "project.json" }, ".git" },
  })

  -- CSS / HTML / JSON
  vim.lsp.config("cssls", {})
  vim.lsp.config("html", {})
  vim.lsp.config("jsonls", { filetypes = { "json", "jsonc" } })

  -- Python (pyright für Typen)
  vim.lsp.config("pyright", {
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

  -- Ruff LSP (Linting/Format-Hinweise für Python)
  vim.lsp.config("ruff_lsp", {
    init_options = {
      settings = {
        args = {}, -- optional: z. B. { "--line-length=100" }
      },
    },
  })

  -- Bash
  vim.lsp.config("bashls", { filetypes = { "sh" } })

  -- Solidity
  vim.lsp.config("solidity", { filetypes = { "solidity" } })

  -- Emmet
  vim.lsp.config("emmet_ls", {
    filetypes = {
      "html",
      "typescriptreact",
      "javascriptreact",
      "javascript",
      "typescript",
      "css",
      "sass",
      "scss",
      "less",
      "svelte",
      "vue",
    },
  })

  -- TypeScript/JavaScript (ts_ls)
  vim.lsp.config("ts_ls", {
    filetypes = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
    },
    root_markers = { { "package.json", "tsconfig.json" }, ".git" },
  })

  -- ESLint LSP (Linting für JS/TS/React, abhängig von Projekt-ESLint-Config)
  vim.lsp.config("eslint", {
    root_markers = {
      ".eslintrc",
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.json",
      "package.json",
    },
  })

  -- Docker
  vim.lsp.config("dockerls", {})

  -- Server aktivieren
  vim.lsp.enable({
    "lua_ls",
    "prismals",
    "angularls",
    "cssls",
    "html",
    "jsonls",
    "pyright",
    "ruff_lsp",
    "bashls",
    "solidity",
    "emmet_ls",
    "ts_ls",
    "eslint",
    "dockerls",
  })
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  lazy = false,
  dependencies = {
    "windwp/nvim-autopairs",
    "williamboman/mason.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
  },
}
