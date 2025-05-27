#!/bin/bash
set -e

DOTFILES_URL="git@github.com:sinancang/dotfiles.git"
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
ln -sf "$DOTFILES_DIR/nvim/init.lua"    ~/.config/nvim/init.lua
ln -sf "$DOTFILES_DIR/nvim/lua"         ~/.config/nvim/lua
ln -sf "$DOTFILES_DIR/nvim/stylua.toml" ~/.config/nvim/stylua.toml
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

# 4b) fzf shell integration via example scripts, with logging
KEYBINDINGS_SCRIPT="/usr/share/doc/fzf/examples/key-bindings.bash"
COMPLETION_SCRIPT="/usr/share/doc/fzf/examples/completion.bash"

# 4c) Alias vi to nvim
ALIAS_LINE='alias vi="nvim"'
if grep -Fxq "$ALIAS_LINE" "$BASHRC"; then
  log "Skipped: vi alias already in $BASHRC"
else
  log "Adding vi alias to $BASHRC"
  echo "$ALIAS_LINE" >> "$BASHRC"
fi

# fzf key bindings (Ctrl-T, Ctrl-R, Alt-C)
if [ -f "$KEYBINDINGS_SCRIPT" ]; then
  LINE="source $KEYBINDINGS_SCRIPT"
  if grep -Fxq "$LINE" "$BASHRC"; then
    log "Skipped: fzf key bindings already in $BASHRC"
  else
    log "Adding fzf key bindings to $BASHRC"
    echo "$LINE" >> "$BASHRC"
  fi
else
  log "Warning: fzf key-bindings script not found at $KEYBINDINGS_SCRIPT"
fi

# fzf completion (Tab)
if [ -f "$COMPLETION_SCRIPT" ]; then
  LINE="source $COMPLETION_SCRIPT"
  if grep -Fxq "$LINE" "$BASHRC"; then
    log "Skipped: fzf completion already in $BASHRC"
  else
    log "Adding fzf completion to $BASHRC"
    echo "$LINE" >> "$BASHRC"
  fi
else
  log "Warning: fzf completion script not found at $COMPLETION_SCRIPT"
fi

log "Dotfiles setup complete! Reload your terminal."

# 5) Set Git default editor to nvim
CURRENT_EDITOR=$(git config --global core.editor || echo "")
if [ "$CURRENT_EDITOR" = "nvim" ]; then
  log "Skipped: Git core.editor already set to nvim"
else
  log "Setting Git core.editor to nvim"
  git config --global core.editor "nvim"
fi
