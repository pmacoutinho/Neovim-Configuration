# Neovim Configuration

Personal Neovim setup in Lua with a modern plugin workflow (managed by `lazy.nvim`). This repo is meant to be fast to install, easy to extend, and safe to try without touching your current config.

> **Tested on modern Neovim.** A recent Neovim (0.9+) is recommended.

---

## Highlights

- **Lua-first** configuration with a single `init.lua`
- **Plugin management with `lazy.nvim`** (lockfile included for reproducible installs)
- **LSP-ready** (uses Neovim’s built-in LSP; add the servers/tools you need)
- Sensible defaults, organized structure, and easy-to-extend modules

---

## Requirements

- **Neovim** ≥ 0.9 (0.10+ recommended)
- **Git**
- Optional but recommended CLI tools:
  - [`ripgrep`](https://github.com/BurntSushi/ripgrep) for fast text search
  - `fd` (or `fdfind`) for fast file search
  - A **Nerd Font** if you like icon support in your UI

---

## Quick Start

### Option A — Try it safely (doesn’t touch `~/.config/nvim`)
Use Neovim’s `NVIM_APPNAME` to run this config in its own profile:

```bash
# 1) Clone to a dedicated config folder
git clone https://github.com/pmacoutinho/Neovim-Configuration \
  ~/.config/pmacoutinho-nvim

# 2) Launch Neovim with this profile
NVIM_APPNAME=pmacoutinho-nvim nvim
