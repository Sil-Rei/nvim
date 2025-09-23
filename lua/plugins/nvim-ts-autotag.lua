return {
  "windwp/nvim-ts-autotag",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename_tag = true,
        enable_rename_on_type = true,
        enable_close_on_slash = true,
      },
      filetypes = {
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "tsx",
        "jsx",
        "vue",
        "svelte",
        "xml",
      },
      skip_filetypes = { "markdown" },
    })
  end,
}
