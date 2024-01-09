local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------
-- remap ctrl d/u to center screen as well
keymap.set("n", "<C-u>", "<C-u>zz", {silent = true})
keymap.set("n", "<C-d>", "<C-d>zz", {silent = true})
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- Quit without saving
keymap.set("n", "<leader>q", ":qa!<CR>") -- Quit all without saving

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
-- Pane and Window Navigation
keymap.set("n", "<C-h>", "<C-w>h") -- Navigate Left
keymap.set("n", "<S-M-j>", "<C-w>j") -- Navigate Down
keymap.set("n", "<S-M-k>", "<C-w>k") -- Navigate Up
keymap.set("n", "<C-l>", "<C-w>l") -- Navigate Right
keymap.set("t", "<C-h>", "<C-w>h") -- Navigate Left (in terminal mode)
keymap.set("t", "<C-j>", "<C-w>j") -- Navigate Down (in terminal mode)
keymap.set("t", "<C-k>", "<C-w>k") -- Navigate Up (in terminal mode)
keymap.set("t", "<C-l>", "<C-w>l") -- Navigate Right (in terminal mode)
keymap.set("n", "<C-h>", "TmuxNavigateLeft") -- Navigate Left (TmuxNavigateLeft)
keymap.set("n", "<C-j>", "TmuxNavigateDown") -- Navigate Down (TmuxNavigateDown)
keymap.set("n", "<C-k>", "TmuxNavigateUp") -- Navigate Up (TmuxNavigateUp)
keymap.set("n", "<C-l>", "TmuxNavigateRight") -- Navigate Right (TmuxNavigateRight)
----------------------
-- Plugin Keybinds
----------------------
-- ToggleTerm
keymap.set("n", "<C-i>", ":ToggleTerm<CR>", { noremap = true, silent = true }) -- open / close
keymap.set({ "i", "v" }, "<C-i>", "<ESC>:ToggleTerm<CR>", { noremap = true, silent = true }) -- open / close
keymap.set({"n", "t"}, "<leader>ä", "<cmd>resize +3<CR>", {noremap = true, silent = true})
keymap.set({"n", "t"}, "<leader>ö", "<cmd>resize -2<CR>", {noremap = true, silent = true})


-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true }) -- toggle file explorer
keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", { noremap = true, silent = true })

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
