-- ~/.config/nvim/lua/config/keymaps.lua

local map = vim.keymap.set

-- Save file
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

-- Quit Neovim
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })

-- Open file explorer (replace with a plugin later)
map("n", "<leader>e", "<cmd>Explore<cr>", { desc = "File explorer" })

-- Toggle nvim-tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

-- Jump from buffer → nvim-tree
map("n", "<leader>E", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })
