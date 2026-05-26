# Terminal aesthetic (macOS)

Ghostty + zsh + zinit + Starship (Catppuccin Mocha) + modern CLI tools. One script.

## What ships

- **Ghostty** terminal
- **JetBrains Mono Nerd Font** (for prompt glyphs)
- **Starship** prompt — Catppuccin Mocha, segmented powerline style
- **zsh + zinit** with async plugins:
  - `fast-syntax-highlighting`
  - `zsh-autosuggestions`
  - `zsh-completions`
- **zoxide** — `z <partial>` jumps to frequent dir
- **fzf** — `Ctrl-R` history search, `Ctrl-T` file picker
- Aliases: `ls`/`ll`/`la`/`lt` → eza · `cat` → bat · `find` → fd

## Install

```bash
git clone <this-repo> ~/terminal-aesthetic
cd ~/terminal-aesthetic
chmod +x install.sh
./install.sh
```

Then:

1. `exec zsh`
2. Ghostty → Settings → **Font: JetBrainsMono Nerd Font**

## Files

| Path | Purpose |
|---|---|
| `Brewfile` | brew packages + casks |
| `install.sh` | idempotent installer (brew + symlinks) |
| `dotfiles/zshrc` | shell config + aliases + zinit bootstrap |
| `dotfiles/starship.toml` | prompt theme |

## Uninstall

Backups at `~/.zshrc.bak`, `~/.config/starship.toml.bak`. Restore manually.
