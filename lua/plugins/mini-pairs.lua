return {
  "echasnovski/mini.pairs",
  version = "*",
  event = "InsertEnter",
  opts = {
  },
  config = function(_, opts)
    require("mini.pairs").setup(opts)
  end,
}
