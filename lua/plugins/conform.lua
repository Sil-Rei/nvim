-- lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  event = "BufReadPre",
  opts = {
    format_on_save = function(_)
      return {
        timeout_ms = 800,
        lsp_fallback = false,
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      python = {"black" },
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      html = { "prettierd" },
      htmlangular = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      less = { "prettierd" },
      svelte = { "prettierd" },
      vue = { "prettierd" },
      sh = { "shfmt" },
      markdown = { "prettierd" },
      prisma = { "prettierd" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      objc = { "clang_format" },
      objcpp = { "clang_format" },
      cmake = { "cmake_format" }
    },
    formatters = {
      shfmt = { prepend_args = { "-i", "2", "-ci" } },
      stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } },
      clang_format = {
        prepend_args = { "--style=file" },
      },
      cmake_format = {
      },
    },
  },
}
