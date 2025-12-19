local on_attach = require("util.lsp").on_attach

local config = function()
  local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
  if not vim.env.PATH:find(mason_bin, 1, true) then
    vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
  end

  -- Diagnostics
  local signs = { Error = "", Warn = "", Hint = "", Info = "" }
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

  -- Global defaults
  vim.lsp.config("*", {
    on_attach = on_attach,
    capabilities = (function()
      local ok, blink = pcall(require, "blink.cmp")
      return ok and blink.get_lsp_capabilities() or nil
    end)(),
    root_markers = { ".git" },
  })

  -- C/C++ (clangd)
  vim.lsp.config("clangd", {
    cmd = {
      "clangd",
      "--background-index",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
      "--fallback-style=LLVM",
    },
    root_markers = { "compile_commands.json", "CMakeLists.txt", ".git" },
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
    cmd = { "prisma-language-server", "--stdio" },
    filetypes = { "prisma" },
    root_markers = { "schema.prisma", ".git" },
  })

  -- Angular
  vim.lsp.config("angularls", {
    filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
    root_markers = { "angular.json", "project.json", ".git" },
  })

  -- CSS / HTML / JSON
  vim.lsp.config("cssls", {})
  vim.lsp.config("html", {})
  vim.lsp.config("jsonls", { filetypes = { "json", "jsonc" } })

  -- Python (pyright)
  vim.lsp.config("pyright", {
    settings = {
      pyright = {
        disableOrganizeImports = true, -- Ruff macht das besser
      },
      python = {
        analysis = {
          useLibraryCodeForTypes = true,
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          autoImportCompletions = true,
        },
      },
    },
  })

  -- Ruff (native server)
  vim.lsp.config("ruff", {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".git" },
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

  -- TypeScript/JavaScript
  vim.lsp.config("ts_ls", {
    filetypes = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
    },
    root_markers = {
      "pnpm-workspace.yaml",
      "yarn.workspaces.json",
      "package.json",
      "tsconfig.json",
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
  vim.lsp.config("dockerls", {
    cmd = { "docker-langserver", "--stdio" },
  })

  -- Enable only what you want
  vim.lsp.enable({
    "lua_ls",
    "clangd",
    "prismals",
    "dockerls",
    "angularls",
    "cssls",
    "html",
    "jsonls",
    "pyright",
    "ruff",
    "bashls",
    "solidity",
    "emmet_ls",
    "ts_ls",
    "eslint",
  })
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", config = true },
  },
  config = config,
}
