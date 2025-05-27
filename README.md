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
