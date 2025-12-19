pcall(function()
  if vim.loader and vim.loader.enable then
    vim.loader.enable()
  end
end)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

if not (uv and uv.fs_stat and uv.fs_stat(lazypath)) then
  if vim.fn.isdirectory(lazypath) == 0 then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
end

vim.opt.rtp:prepend(lazypath)

-- Deine Basis-Configs
require("config.options")
require("config.keymaps")

-- Lazy Setup
require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "nordic" } },

  ui = {
    border = "rounded",
    wrap = false,
    size = { width = 0.9, height = 0.9 },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "netrw",
      },
    },
  },

  change_detection = {
    enabled = true,
    notify = true,
  },

  checker = {
    enabled = false,
    notify = false,
    frequency = 3600 * 6,
  },
})

-- Highlight for Yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 150,
    })
  end,
})

-- util for delaying lsp on oil start
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = function(args)
    -- Wenn es keine Oil-Datei ist, feuere das "FileOpened" Event
    if vim.bo[args.buf].filetype ~= "oil" then
      vim.api.nvim_exec_autocmds("User", { pattern = "FileOpened" })
    end
  end,
})
