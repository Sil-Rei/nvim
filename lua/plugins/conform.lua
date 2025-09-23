-- lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  event = "BufReadPre",
  opts = {
    format_on_save = function(_)
      return {
        timeout_ms = 400,
        lsp_fallback = false, -- nur explizite Formatter verwenden
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      -- Python: nimm EINE Linie: ruff (schnell) ODER black (klassisch)
      python = { "ruff_format", "ruff_organize_imports" }, -- oder { "black" }
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      less = { "prettierd" },
      svelte = { "prettierd" },
      vue = { "prettierd" },
      sh = { "shfmt" },
      markdown = { "prettierd" },
      prisma = { "prettierd" },
      -- solidity/dockerfile haben meist keinen Auto-Formatter
    },
    formatters = {
      shfmt = { prepend_args = { "-i", "2", "-ci" } },
      stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } },
    },
  },
}
