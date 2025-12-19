local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------
-- GG/G Anpassungen
keymap.set("n", "gg", "gg0")
keymap.set("n", "G", "G$")

-- Zentriertes Scrollen
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")

-- Exit Insert Mode
keymap.set("i", "jk", "<ESC>")

-- Quit all without saving
keymap.set("n", "<leader><ESC>", ":qa!<CR>")
keymap.set("v", "<leader><ESC>", "<Esc>:qa!<CR>", { desc = "Quit all without saving" })

-- Quick save
keymap.set("n", "<leader>w", ":w<CR>")

-- Indenting (bleibt im Visual Mode)
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Delete single character without register
keymap.set("n", "x", '"_x')

-- Increment/Decrement
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- Oil
keymap.set("n", "<leader>ö", "<cmd>Oil<cr>")

-- Restart LSP
keymap.set("n", "<leader>rs", ":LspRestart<CR>")

---------------------
-- LSP Keymaps (Ersetzt util/lsp.lua)
---------------------
-- Diese Maps sind jetzt global und nutzen direkt Snacks.picker
local map = function(mode, lhs, rhs, desc)
  keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("n", "gd", function()
  Snacks.picker.lsp_definitions()
end, "Goto Definition")
map("n", "gr", function()
  Snacks.picker.lsp_references()
end, "References")
map("n", "gI", function()
  Snacks.picker.lsp_implementations()
end, "Implementations")
map("n", "gy", function()
  Snacks.picker.lsp_type_definitions()
end, "Type Definitions")
map("n", "K", vim.lsp.buf.hover, "Hover")
map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

-- Diagnostics
map("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, { scope = "line", border = "rounded" })
end, "Line Diagnostics")

map("n", "<leader>sd", function()
  Snacks.picker.diagnostics()
end, "Diagnostics Picker")

---------------------
-- Smart Build & Run (Dein WezTerm Script)
---------------------
keymap.set("n", "<leader>r", function()
  vim.cmd("silent! wa")
  local pane = vim.fn.system("wezterm cli get-pane-direction down"):gsub("%s+", "")
  if pane == "" then
    vim.notify("Kein unterer Pane! Nutze CMD+s für Split.", vim.log.levels.WARN)
    return
  end

  local ft = vim.bo.filetype
  local cmd = ""

  local runners = {
    python = "clear && python3 %s",
    javascript = "clear && node %s",
    typescript = "clear && node %s",
    cpp = "clear && cmake --build --preset dev && ./build/myapp",
    c = "clear && cmake --build --preset dev && ./build/myapp",
  }

  local runner_cmd = runners[ft]
  if not runner_cmd then
    vim.notify("Kein Runner für Filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  if ft == "python" or ft == "javascript" or ft == "typescript" then
    cmd = string.format(runner_cmd, vim.fn.expand("%:p"))
  else
    cmd = runner_cmd
  end

  vim.fn.system(string.format("wezterm cli send-text --pane-id %s --no-paste '%s\n'", pane, cmd))
end, { desc = "Smart Build & Run in Wezterm" })
