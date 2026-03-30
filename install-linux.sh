#!/bin/bash
set -euo pipefail

# ─── Colors ───────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[✓]${NC} $*"; }
warn()  { echo -e "${YELLOW}[!]${NC} $*"; }
error() { echo -e "${RED}[✗]${NC} $*"; }

# ─── Helpers ──────────────────────────────────────────────────────────
command_exists() { command -v "$1" &>/dev/null; }

ensure_apt_updated() {
  if [ "${APT_UPDATED:-0}" = "0" ]; then
    info "Updating apt..."
    sudo apt-get update -qq
    APT_UPDATED=1
  fi
}

# ─── System packages ─────────────────────────────────────────────────
install_system_deps() {
  info "Installing base packages..."
  ensure_apt_updated
  sudo apt-get install -y build-essential git curl unzip
}

# ─── Rust + Tuckr ────────────────────────────────────────────────────
install_rust() {
  if command_exists rustc; then
    info "Rust already installed ($(rustc --version))"
  else
    info "Installing Rust..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source "$HOME/.cargo/env"
  fi
}

install_tuckr() {
  if command_exists tuckr; then
    info "Tuckr already installed ($(tuckr --version 2>/dev/null || echo 'ok'))"
  else
    info "Installing Tuckr..."
    cargo install tuckr
  fi
}

# ─── tmux ─────────────────────────────────────────────────────────────
install_tmux() {
  if command_exists tmux; then
    info "tmux already installed ($(tmux -V))"
  else
    info "Installing tmux..."
    ensure_apt_updated
    sudo apt-get install -y tmux
  fi

  # TPM
  if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    info "TPM already installed"
  else
    info "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

# ─── Neovim ───────────────────────────────────────────────────────────
NVIM_VERSION="v0.10.4"
NVIM_INSTALL_DIR="$HOME/.local/nvim"

install_neovim() {
  if command_exists nvim; then
    local current
    current=$(nvim --version | head -1 | grep -oP 'v[\d.]+')
    info "Neovim already installed ($current)"

    if [ "$current" = "$NVIM_VERSION" ]; then
      return
    else
      warn "Installed version ($current) differs from target ($NVIM_VERSION)"
      read -rp "    Update to $NVIM_VERSION? [y/N] " answer
      if [[ ! "$answer" =~ ^[Yy]$ ]]; then
        return
      fi
    fi
  fi

  info "Installing Neovim $NVIM_VERSION..."
  local arch
  arch=$(uname -m)
  local tarball="nvim-linux-${arch}.tar.gz"
  local url="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${tarball}"

  curl -fLo "/tmp/${tarball}" "$url"
  rm -rf "$NVIM_INSTALL_DIR"
  mkdir -p "$NVIM_INSTALL_DIR"
  tar xzf "/tmp/${tarball}" -C "$NVIM_INSTALL_DIR" --strip-components=1
  rm -f "/tmp/${tarball}"

  # Ensure it's on PATH
  if ! echo "$PATH" | grep -q "$NVIM_INSTALL_DIR/bin"; then
    warn "Add to your PATH: export PATH=\"$NVIM_INSTALL_DIR/bin:\$PATH\""
  fi

  info "Neovim installed at $NVIM_INSTALL_DIR/bin/nvim"
}

# ─── Oh My Zsh ────────────────────────────────────────────────────────
install_ohmyzsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    info "Oh My Zsh already installed"
  else
    info "Installing Oh My Zsh..."
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  # zsh-autosuggestions
  local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  if [ -d "$plugin_dir" ]; then
    info "zsh-autosuggestions already installed"
  else
    info "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir"
  fi
}

# ─── Config directories ──────────────────────────────────────────────
create_config_dirs() {
  info "Creating config directories..."
  mkdir -p ~/.config/nvim
  mkdir -p ~/.config/opencode/themes
  mkdir -p ~/.config/opencode/skills
}

# ─── Deploy dotfiles ─────────────────────────────────────────────────
deploy_dotfiles() {
  if command_exists tuckr; then
    info "Deploying dotfiles with Tuckr..."
    tuckr add '*'
    info "Dotfiles deployed! Run 'tuckr status' to verify."
  else
    error "Tuckr not found — skipping dotfile deployment"
  fi
}

# ─── Summary ──────────────────────────────────────────────────────────
print_summary() {
  echo ""
  echo -e "${GREEN}═══════════════════════════════════════${NC}"
  echo -e "${GREEN}  Setup complete!${NC}"
  echo -e "${GREEN}═══════════════════════════════════════${NC}"
  echo ""
  echo "  Next steps:"
  echo "    1. Restart your shell:  exec zsh"
  echo "    2. Open tmux and press: Ctrl-s + I  (install plugins)"
  echo "    3. Open nvim — lazy.nvim auto-installs plugins"
  echo "    4. In nvim run:         :Mason      (verify LSP servers)"
  echo ""
}

# ─── Main ─────────────────────────────────────────────────────────────
main() {
  echo ""
  echo "╔═══════════════════════════════════════╗"
  echo "║      .dotfiles installer (WSL)        ║"
  echo "╚═══════════════════════════════════════╝"
  echo ""

  install_system_deps
  install_rust
  install_tuckr
  install_tmux
  install_neovim
  install_ohmyzsh
  create_config_dirs
  deploy_dotfiles
  print_summary
}

main "$@"
