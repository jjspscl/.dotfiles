# .dotfiles

Personal dotfiles managed with [Tuckr](https://github.com/RaphGL/Tuckr).

## 📦 What's Inside

| Group | Config | Description |
|-------|--------|-------------|
| `zshrc` | `.zshrc` | Zsh + Oh My Zsh, Volta, Bun, mise, OpenClaw completions |
| `tmux` | `.tmux.conf` | tmux with TPM, vim keys, minimal-tmux-status theme |

## 🚀 Setup

### Prerequisites

- [Tuckr](https://github.com/RaphGL/Tuckr) (`cargo install tuckr`)
- [Oh My Zsh](https://ohmyz.sh/)
- [TPM](https://github.com/tmux-plugins/tpm) (tmux plugin manager)

### Install

```bash
# Clone
git clone git@github.com:jjspscl/.dotfiles.git ~/.dotfiles

# Deploy all configs
tuckr add '*'

# Deploy with hooks (installs plugins, etc.)
tuckr set '*'

# Check status
tuckr status
```

### Manage

```bash
# Add specific group
tuckr add zshrc

# Remove symlinks
tuckr rm tmux

# See what's linked
tuckr status
```

## 🌿 Branches

- **`main`** — clean base configs
- **`leighton`** — WSL2 customizations (bun, mise, opencode, OpenClaw, Android SDK, minimal-tmux-status)

## 📁 Structure

```
.dotfiles/
├── Configs/
│   ├── tmux/
│   │   └── .tmux.conf
│   └── zshrc/
│       └── .zshrc
├── Hooks/
│   ├── tmux/
│   │   └── pre.sh        # Installs TPM
│   └── zshrc/
│       └── pre.sh        # Installs zsh plugins
├── install-linux.sh
└── README.md
```

## 📝 License

Personal use. Do whatever you want with it ✌️
