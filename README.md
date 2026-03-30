# .dotfiles

Personal dotfiles managed with [Tuckr](https://github.com/RaphGL/Tuckr).

## 📦 What's Inside

| Group | Config | Description |
|-------|--------|-------------|
| `zshrc` | `.zshrc` | Zsh + Oh My Zsh, Volta, Bun, mise, OpenClaw completions |
| `tmux` | `.tmux.conf` | tmux with TPM, vim keys, Kanagawa theme, minimal-tmux-status, tmux-sm |
| `nvim` | `.config/nvim/` | Kickstart-based Neovim — Kanagawa Dragon, lazy.nvim, LSP, DAP, Copilot |
| `opencode` | `.config/opencode/` | OpenCode 5-agent config, Kanagawa transparent theme |

## 🎨 Theme

Everything uses a unified **Kanagawa** color palette:

| Surface | Theme |
|---------|-------|
| Neovim | kanagawa-dragon (transparent) |
| tmux | Kanagawa via minimal-tmux-status |
| OpenCode | kanagawa-transparent |

## 🚀 Setup

### Prerequisites

- [Tuckr](https://github.com/RaphGL/Tuckr) — `cargo install tuckr`
- [Oh My Zsh](https://ohmyz.sh/) — `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- [TPM](https://github.com/tmux-plugins/tpm) — `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- A [Nerd Font](https://www.nerdfonts.com/) installed in your terminal

### Install

```bash
# 1. Clone the repo
git clone git@github.com:jjspscl/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git checkout leighton-pc

# 2. Install base dependencies (Linux/WSL)
./install-linux.sh

# 3. Create required directories
mkdir -p ~/.config/opencode/themes ~/.config/opencode/skills
mkdir -p ~/.config/nvim

# 4. Deploy all configs + run hooks
tuckr set '*'
# Or deploy individually:
#   tuckr add zshrc tmux nvim opencode

# 5. Install tmux plugins (inside tmux)
# Press: Ctrl-s + I

# 6. Install Neovim plugins (first launch)
nvim
# lazy.nvim auto-installs on first run
# Then run :Mason to verify LSP servers
```

### Post-Install

```bash
# Install zsh-autosuggestions (if hooks didn't run)
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install Volta (Node version manager)
curl https://get.volta.sh | bash

# Reload shell
source ~/.zshrc
```

## 🔧 Manage

```bash
# Add a specific group
tuckr add nvim

# Remove symlinks for a group
tuckr rm tmux

# Redeploy everything (with hooks)
tuckr set '*'

# Check status
tuckr status
```

## 📁 Structure

```
.dotfiles/
├── Configs/
│   ├── tmux/
│   │   └── .tmux.conf
│   ├── zshrc/
│   │   └── .zshrc
│   ├── nvim/
│   │   └── .config/nvim/
│   │       ├── init.lua
│   │       ├── lazy-lock.json
│   │       └── lua/kickstart/plugins/
│   │           ├── gitsigns.lua
│   │           ├── indent_line.lua
│   │           └── neo-tree.lua
│   └── opencode/
│       └── .config/opencode/
│           ├── opencode.json
│           ├── tui.json
│           ├── themes/kanagawa-transparent.json
│           └── skills/tamagui.md
├── Hooks/
│   ├── tmux/
│   │   └── pre.sh          # Installs TPM
│   └── zshrc/
│       └── pre.sh          # Installs zsh-autosuggestions + Volta
├── install-linux.sh         # Base packages, Rust, Tuckr
└── README.md
```

## ⌨️ Key Bindings

### tmux (`Ctrl-s` prefix)

| Key | Action |
|-----|--------|
| `prefix + r` | Reload config |
| `prefix + h/j/k/l` | Navigate panes |
| `prefix + S` | Session manager (tmux-sm) |
| `prefix + I` | Install TPM plugins |

### Neovim (`Space` leader)

| Key | Action |
|-----|--------|
| `Ctrl-p` | Find files |
| `Ctrl-b` | Toggle file tree (Neo-tree) |
| `<leader>sf` | Search files |
| `<leader>sg` | Search by grep |
| `<leader>f` | Format buffer |
| `<leader>b` | Toggle breakpoint |
| `F5` | Debug: Start/Continue |
| `grn` | LSP: Rename |
| `grd` | LSP: Go to definition |
| `grr` | LSP: Find references |

### OpenCode Agents

| Agent | Role |
|-------|------|
| `build` | Default — end-to-end implementation |
| `plan` | Scoping, constraints, sequencing |
| `tester` | Validation, regression, reproduction |
| `product-manager` | Intent, acceptance criteria, scope |
| `code-reviewer` | Correctness, security, architecture review |

## 🌿 Branches

- **`main`** — clean base configs
- **`leighton-pc`** — Full WSL2 setup (Kanagawa theme, nvim, opencode, Android SDK, bun, mise)

## 📝 License

Personal use. Do whatever you want with it ✌️
