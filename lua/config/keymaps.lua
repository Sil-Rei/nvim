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
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("silent! wa")

  -- Pane Check
  local pane = vim.fn.system("wezterm cli get-pane-direction down"):gsub("%s+", "")
  if pane == "" then
    vim.notify("Kein unterer Pane! Nutze CMD+S für Split.", vim.log.levels.WARN)
    return
  end

  local ft = vim.bo.filetype
  local cmd = ""
  local filepath = vim.fn.expand("%:p")
  local project_root = vim.fn.expand("%:p:h")

  -- Runner Logik
  if ft == "python" then
    cmd = string.format("clear && python3 '%s'", filepath)
  elseif ft == "javascript" or ft == "typescript" then
    -- Falls du ts-node oder bun nutzt, hier anpassen
    cmd = string.format("clear && node '%s'", filepath)
  elseif ft == "cpp" or ft == "c" then
    -- Intelligenter C++ Build
    if vim.fn.filereadable("CMakeLists.txt") == 1 then
      -- Wir nehmen an, dass ein 'dev' preset existiert oder wir nutzen den Standard
      -- Falls kein Preset da ist, kann man auch 'cmake --build build' nehmen
      cmd = "clear && cmake --build --preset dev"

      -- Versuch das Binary zu finden: oft wie das Verzeichnis benannt
      local binary = "./build/myapp" -- Dein Default
      if vim.fn.isdirectory("build") == 1 then
        cmd = cmd .. " && " .. binary
      end
    elseif vim.fn.filereadable("Makefile") == 1 then
      cmd = 'clear && make -j$(nproc) && ./$(basename "$PWD")'
    else
      -- Single File Compile für kleine Uni-Aufgaben
      local out = vim.fn.expand("%:r")
      cmd = string.format("clear && g++ -std=c++20 '%s' -o '%s' && '%s'", filepath, out, out)
    end
  elseif ft == "sh" then
    cmd = string.format("clear && bash '%s'", filepath)
  end

  if cmd == "" then
    vim.notify("Kein Runner für Filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  -- Abfahrt!
  vim.fn.system(string.format("wezterm cli send-text --pane-id %s --no-paste '%s\n'", pane, cmd))
end, { desc = "Smart Build & Run in Wezterm" })
