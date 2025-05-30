-- Set space as leader
vim.g.mapleader = " "

local map = vim.keymap.set

-- Configure Ctrl + Right/Left to jump over words
map("", "<C-Right>", "e", { noremap = true })
map("", "<C-Left>", "b", { noremap = true })
map("i", "<C-Right>", "<Esc>eli", { noremap = true })
map("i", "<C-Left>", "<C-O>b", { noremap = true })

-- Use `jj` to exit insert mode
map("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Tab to indent right in visual mode
map("v", "<Tab>", ">gv", { noremap = true, silent = true })

-- Shift-Tab to indent left in visual mode
map("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- use + to move up as well
map("n", "+", "k", { noremap = true, silent = true })

