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

  -- C/C++ (clangd)
  vim.lsp.config("clangd", {
    cmd = {
      "clangd",
      "--background-index",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
      "--fallback-style=LLVM",
      -- Optional: Pfad zur compile_commands.json automatisch erkennen:
      -- "--compile-commands-dir=build"
    },
    root_markers = {
      { "compile_commands.json", "CMakeLists.txt" },
      ".git",
    },
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
      "htmlangular",
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

-- TypeScript/JavaScript (Fallback: ts_ls)
vim.lsp.config("ts_ls", {
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
      suggest = { completeFunctionCalls = true },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = true,
      },
    },
  },
})  -- ESLint
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
    "clangd"
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
