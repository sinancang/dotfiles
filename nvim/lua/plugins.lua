return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",    -- pin to v6.x (latest stable: v6.1.0) :contentReference[oaicite:11]{index=11}
    lazy = false,      -- plugin lazy-loads itself on Rust filetypes :contentReference[oaicite:12]{index=12}
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",                -- ensure grammars stay up to date
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "rust" },    -- install the Rust parser
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "mhartington/oceanic-next",        -- Oceanic Next theme repo
    lazy     = false,                  -- load immediately so :colorscheme works
    priority = 1000,                   -- high priority to apply before others :contentReference[oaicite:1]{index=1}
    config   = function()
      -- enable true-color support
      vim.opt.termguicolors = true     -- use 24-bit RGB colors in the terminal :contentReference[oaicite:2]{index=2}
      -- turn on the built-in syntax engine
      vim.cmd("syntax enable")         -- ensure syntax groups are defined :contentReference[oaicite:3]{index=3}

      -- optional: enable terminal bold/italic (requires a compatible font & terminal)
      vim.g.oceanic_next_terminal_bold   = 1  -- allow bold fonts :contentReference[oaicite:4]{index=4}
      vim.g.oceanic_next_terminal_italic = 1  -- allow italic fonts :contentReference[oaicite:5]{index=5}

      -- finally, apply the theme
      vim.cmd("colorscheme OceanicNext")     -- set Oceanic Next as your colorscheme :contentReference[oaicite:6]{index=6}
    end,
  }
}

