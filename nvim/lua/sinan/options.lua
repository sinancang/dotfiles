local opt= vim.opt

opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.cursorline = true
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
 
opt.whichwrap:append("<,>,[,],h,l")  -- Allow left/right movement across line boundaries
opt.virtualedit = "onemore"          -- Allow cursor *after* the last character

opt.timeoutlen = 300  -- Time (ms) to wait for a mapped sequence

