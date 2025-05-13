#!/bin/bash

# Clone dotfiles if not already present
if [ ! -d "$HOME/dotfiles" ]; then
    git clone https://github.com/sgulan/dotfiles.git ~/dotfiles
fi

# Setup Neovim Config
mkdir -p ~/.config
ln -sf ~/dotfiles/nvim ~/.config/nvim

echo "Dotfiles setup complete! Reload your terminal."

