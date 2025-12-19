return {
  "dstein64/nvim-scrollview",
  event = "VeryLazy",
  config = function()
    require("scrollview").setup({
      excluded_filetypes = { "nvim-tree", "NvimTree", "dashboard", "alpha" },
      current_only = true,
      always_show = false,
    })
  end,
}
