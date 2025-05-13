-- Set space as leader
vim.g.mapleader = " "

local map = vim.keymap.set

-- Configure Ctrl + Right/Left to jump over words
map('', '<C-Right>', 'e', { noremap = true })
map('', '<C-Left>', 'b', { noremap = true })

-- Use `jj` to exit insert mode
map('i', 'jj', '<Esc>', { noremap = true, silent = true })

