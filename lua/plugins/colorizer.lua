return {
  "norcalli/nvim-colorizer.lua",
  ft = {
    "css",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
  },
  config = function()
    require("colorizer").setup({
      "css",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    })
  end,
}
