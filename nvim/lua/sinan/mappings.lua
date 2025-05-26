-- Set space as leader
vim.g.mapleader = " "

local map = vim.keymap.set

-- Configure Ctrl + Right/Left to jump over words
map("", "<C-Right>", "e", { noremap = true })
map("", "<C-Left>", "b", { noremap = true })

-- Use `jj` to exit insert mode
map("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Tab to indent right in visual mode
map("v", "<Tab>", ">gv", { noremap = true, silent = true })

-- Shift-Tab to indent left in visual mode
map("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Open floating diagnostics
-- map("n", "<leader>e", vim.diagnostic.open_float, { buffer = 0 })
