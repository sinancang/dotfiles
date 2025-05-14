#!/bin/bash
set -e

DOTFILES_URL="https://github.com/sgulan/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
BASHRC="$HOME/.bashrc"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

# 1) Clone dotfiles if not already present
if [ ! -d "$DOTFILES_DIR" ]; then
  log "Cloning dotfiles repo from $DOTFILES_URL into $DOTFILES_DIR"
  git clone "$DOTFILES_URL" "$DOTFILES_DIR"
else
  log "Skipped clone: $DOTFILES_DIR already exists"
fi

# 2) Install fzf and tmux if missing
MISSING=()
command -v fzf  >/dev/null 2>&1 || MISSING+=("fzf")
command -v tmux >/dev/null 2>&1 || MISSING+=("tmux")

if [ ${#MISSING[@]} -ne 0 ]; then
  log "Installing missing packages: ${MISSING[*]}"
  sudo apt-get update
  sudo apt-get install -y "${MISSING[@]}"
else
  log "Skipped install: fzf and tmux already present"
fi

# 3) Setup Neovim Config
log "Setting up Neovim config in ~/.config/nvim"
mkdir -p ~/.config/nvim
ln -sf "$DOTFILES_DIR/nvim/init.lua" ~/.config/nvim/init.lua
ln -sf "$DOTFILES_DIR/nvim/lua"      ~/.config/nvim/lua
log "Neovim config links created"

# 4) Ensure PATH and fzf shell integration in ~/.bashrc, with logging
# 4a) export PATH
LINE='export PATH="/usr/local/bin:$PATH"'
if grep -Fxq "$LINE" "$BASHRC"; then
  log "Skipped: PATH line already in $BASHRC"
else
  log "Adding PATH line to $BASHRC"
  echo "$LINE" >> "$BASHRC"
fi

# 4b) eval fzf
LINE='eval "$(fzf --bash)"'
if grep -Fxq "$LINE" "$BASHRC"; then
  log "Skipped: fzf integration already in $BASHRC"
else
  log "Adding fzf shell integration to $BASHRC"
  echo "$LINE" >> "$BASHRC"
fi

log "Dotfiles setup complete! Reload your terminal."

