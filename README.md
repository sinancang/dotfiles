### dotfiles

Bare-bones setup for my development environment — currently focused on **Neovim**.

The install script (`install.sh`) is synced to a [Gist](https://gist.github.com/sinancang/4899d6b67ffa7c808343cfcbf57bcd81). This allows for installing the configs before even cloning the repo, as such:
```bash
curl -fsSL https://gist.github.com/sinancang/4899d6b67ffa7c808343cfcbf57bcd81/raw/install.sh | bash
```

This will:
* Install tmux and fzf
* Apply the Neovim config by setting up some symlinks
* Alias `vi` to `nvim`

Configs are best when highly personalized, but feel free to borrow and adapt

---

### Plugins

* **`neovim/nvim-lspconfig`** – LSP support for `clangd` and `lua_ls`
* **`folke/neodev.nvim`** – Better Lua completions for Neovim configs
* **`williamboman/mason.nvim`** – Install/manage LSPs and tools
* **`williamboman/mason-lspconfig.nvim`** – Auto-setup for installed LSPs
* **`mrcjkb/rustaceanvim`** – Native Rust support via `rust-analyzer`
* **`hrsh7th/nvim-cmp`** – Completion framework
* **`cmp-nvim-lsp`** – LSP source for `nvim-cmp`
* **`LuaSnip`** + **`cmp_luasnip`** – Snippet support in completion
* **`nvim-treesitter/nvim-treesitter`** – Tree-sitter-based syntax highlighting (Rust enabled)
* **`mhartington/oceanic-next`** – Oceanic Next colorscheme with truecolor + italic/bold

---

### Custom Mappings

* `<leader>` set to **space**
* `jj` to exit insert mode
* `<Tab>` / `<S-Tab>` to indent/un-indent in visual mode
* `<C-Right>` / `<C-Left>` to jump word-wise
* **LSP shortcuts:**

  * `gd`: go to definition
  * `K`: hover
  * `gr`: references
  * `<leader>rn`: rename
  * `<leader>ca`: code action
  * `<leader>f`: format
  * `<leader>e`: diagnostics
  * `<leader>W`: warnings only
  * `<leader>H`: hints only
