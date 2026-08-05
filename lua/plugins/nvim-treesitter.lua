return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- main-Branch unterstützt kein Lazy-Loading
  build = ":TSUpdate",
  cond = function()
    if vim.fn.has("nvim-0.12") == 1 then
      return true
    end
    vim.schedule(function()
      vim.notify(
        "nvim-treesitter (main-Branch) braucht Neovim >= 0.12 – Plugin deaktiviert.\nHier läuft: " .. vim.version().major .. "." .. vim.version().minor,
        vim.log.levels.WARN
      )
    end)
    return false
  end,
  config = function()
    local ts = require("nvim-treesitter")

    -- Alter master-Checkout? Dann fehlen setup/install -> klare Ansage statt Stacktrace.
    if type(ts.install) ~= "function" then
      vim.schedule(function()
        vim.notify(
          "nvim-treesitter ist noch auf dem alten master-Checkout.\nFix: nvim --headless '+Lazy! restore' +qa",
          vim.log.levels.ERROR
        )
      end)
      return
    end

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
