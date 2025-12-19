return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.install").prefer_git = true

    require("nvim-treesitter.configs").setup({
      indent = { enable = true },
      ensure_installed = {
        "markdown",
        "json",
        "javascript",
        "tsx",
        "typescript",
        "yaml",
        "html",
        "css",
        "bash",
        "lua",
        "dockerfile",
        "solidity",
        "gitignore",
        "python",
        "vue",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-s>",
          node_incremental = "<C-s>",
          scope_incremental = false,
          node_decremental = "<BS>",
        },
      },
    })
  end,
}
