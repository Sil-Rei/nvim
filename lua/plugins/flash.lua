return {
  "folke/flash.nvim",
  ---@type Flash.Config
  opts = {},
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- Ersatz für die entfernte incremental_selection von nvim-treesitter
    { "<C-s>", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter Selection" },
  },
}
