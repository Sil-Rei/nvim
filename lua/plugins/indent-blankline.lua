return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = false,
    opts = {
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
