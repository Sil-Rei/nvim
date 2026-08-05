return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- main-Branch unterstützt kein Lazy-Loading
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({})

    local ensure_installed = {
      "markdown",
      "markdown_inline",
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
      "c",
      "cpp",
      "regex",
      "vim",
      "vimdoc",
      "query",
    }
    ts.install(ensure_installed)

    -- Highlighting + Indent pro Buffer aktivieren (ersetzt highlight/indent = { enable = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
