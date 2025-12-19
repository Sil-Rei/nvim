return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown", "quarto", "rmd" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    preview = {
      filetypes = { "markdown", "quarto", "rmd" },
    },
  },
}
