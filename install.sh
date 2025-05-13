#!/bin/bash

# Clone dotfiles if not already present
if [ ! -d "$HOME/dotfiles" ]; then
    git clone https://github.com/sgulan/dotfiles.git ~/dotfiles
fi

# Setup Neovim Config
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/nvim/lua ~/.config/nvim/lua

echo "Dotfiles setup complete! Reload your terminal."

