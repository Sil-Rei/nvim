local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------
-- remap gg to go to first character of line at top of file
keymap.set("n", "gg", "gg0")
-- remap G to go to last character of line at bottom of file
keymap.set("n", "G", "G$")

-- remap ctrl d/u to center screen as well
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- Quit without saving
keymap.set("n", "<leader><ESC>", ":qa!<CR>") -- Quit all without saving
keymap.set("v", "<leader><ESC>", "<Esc>:qa!<CR>", { desc = "Quit all without saving" })

-- quick save write file
keymap.set("n", "<leader>w", ":w<CR>")

-- Indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement
----------------------
-- Plugin Keybinds
----------------------
-- nvim-tree
-- keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true }) -- toggle file explorer
-- keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", { noremap = true, silent = true })

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>")

-- Oil
keymap.set("n", "<leader>ö", "<cmd>Oil<cr>")

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

  vim.fn.system(string.format(
    "wezterm cli send-text --pane-id %s --no-paste '%s\n'",
    pane, cmd
  ))
end, { desc = "Smart Build & Run in Wezterm" })
