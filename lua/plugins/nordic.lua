return {
  "alexvzyl/nordic.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nordic").load()
    vim.api.nvim_set_hl(0, "WinBar", { fg = "#242933", bg = "#242933" })
  end,
}
