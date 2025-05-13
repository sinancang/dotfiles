local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Example Plugins
--    { "nvim-lua/plenary.nvim" },          -- Dependency for other plugins
--    { "nvim-telescope/telescope.nvim" },   -- Fuzzy Finder
--    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- Syntax Highlighting
--    { "folke/tokyonight.nvim" },           -- Theme
--    { "nvim-lualine/lualine.nvim" },       -- Statusline
})

