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
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true }) -- toggle file explorer
keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", { noremap = true, silent = true })

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>")

-- Oil
keymap.set("n", "<leader>ö", "<cmd>Oil<cr>")
