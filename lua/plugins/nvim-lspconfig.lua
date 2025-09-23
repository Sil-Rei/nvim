local on_attach = require("util.lsp").on_attach

local config = function()
  pcall(function()
    require("neoconf").setup({})
  end)

  -- Diagnostics
  local signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
  }

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = signs.Error,
        [vim.diagnostic.severity.WARN] = signs.Warn,
        [vim.diagnostic.severity.HINT] = signs.Hint,
        [vim.diagnostic.severity.INFO] = signs.Info,
      },
    },
    virtual_text = { spacing = 2, prefix = "●" },
    float = { border = "rounded", focusable = true },
    severity_sort = true,
    update_in_insert = false,
  })

  -- Globale Defaults
  vim.lsp.config("*", {
    on_attach = on_attach,
    capabilities = (function()
      local ok, blink = pcall(require, "blink.cmp")
      return ok and blink.get_lsp_capabilities() or nil
    end)(),
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
    filetypes = { "html" },
    root_markers = { { "angular.json", "project.json" }, ".git" },
  })

  -- CSS / HTML / JSON
  vim.lsp.config("cssls", {})
  vim.lsp.config("html", {})
  vim.lsp.config("jsonls", { filetypes = { "json", "jsonc" } })

  -- Python (pyright)
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

  -- Ruff
  vim.lsp.config("ruff_lsp", {
    init_options = {
      settings = {
        args = {},
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

  -- TypeScript/JavaScript
  vim.lsp.config("vtsls", {
    filetypes = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
    },
    root_markers = {
      { "pnpm-workspace.yaml", "yarn.workspaces.json", "package.json", "tsconfig.json" },
      ".git",
    },
    settings = {
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
      },
      typescript = {
        inlayHints = {
          enumMemberValues = true,
          functionLikeReturnTypes = true,
          parameterNames = { enabled = "literals" },
          parameterTypes = true,
          propertyDeclarationTypes = true,
          variableTypes = { enabled = "literals" },
        },
        preferences = {
          includeCompletionsForModuleExports = true,
          includeCompletionsWithInsertTextCompletions = true,
          quoteStyle = "auto",
          importModuleSpecifierPreference = "non-relative",
        },
        suggest = {
          completeFunctionCalls = true,
        },
      },
      javascript = {
        inlayHints = {
          parameterNames = { enabled = "literals" },
          parameterTypes = true,
        },
      },
      tsserver = {
        useSyntaxServer = "auto",
      },
    },
  })

  -- ESLint
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
    "vtsls",
    "eslint",
    "dockerls",
  })
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
  },
}
