return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = false,
    opts = {
      scope = {enabled=false},
      exclude = {
        filetypes = {
          "log",
          "markdown",
          "dashboard",
          "git",
      }
    }
  },
}
