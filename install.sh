#!/usr/bin/env bash
set -euo pipefail

# macOS terminal aesthetic installer.
# Ghostty + zsh + zinit + Starship (Catppuccin Mocha) + modern CLI tools.
# Idempotent — safe to re-run.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES="$SCRIPT_DIR/dotfiles"

log()  { printf "\033[1;36m▸\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m!\033[0m %s\n" "$*"; }

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Brew packages from Brewfile
log "Installing brew packages"
brew bundle --file="$SCRIPT_DIR/Brewfile"

# 3. fzf keybindings
if [ ! -f "$HOME/.fzf.zsh" ]; then
  log "Installing fzf keybindings"
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc
fi

# 4. Backup + symlink dotfiles
link() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    warn "Backing up $dest → $dest.bak"
    mv "$dest" "$dest.bak"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -sf "$src" "$dest"
  log "Linked $dest"
}

link "$DOTFILES/zshrc"          "$HOME/.zshrc"
link "$DOTFILES/starship.toml"  "$HOME/.config/starship.toml"
link "$DOTFILES/ghostty-config" "$HOME/.config/ghostty/config"

cat <<'EOF'

✓ Done

Next:
  1. exec zsh                                          (reload shell)
  2. Restart Ghostty                                   (picks up font + theme)

The Ghostty config is symlinked, so the Nerd Font and Catppuccin Mocha theme
are already set — no need to touch Settings.

First zsh launch auto-installs zinit + plugins (async, takes a few seconds).

EOF
