#!/usr/bin/env bash
set -euo pipefail

info() { printf '\033[0;32m[✓]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$*"; }

need_pacman=()
for pkg in git curl tmux starship lazygit opencode rust; do
  pacman -Q "$pkg" >/dev/null 2>&1 || need_pacman+=("$pkg")
done

if ((${#need_pacman[@]})); then
  warn "Installing missing Arch packages: ${need_pacman[*]}"
  sudo pacman -S --needed "${need_pacman[@]}"
else
  info "Core Arch packages already installed"
fi

if ! command -v tuckr >/dev/null 2>&1; then
  info "Installing Tuckr via cargo"
  cargo install tuckr
else
  info "Tuckr already installed: $(tuckr --version)"
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  info "Installing TPM"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
  info "TPM already installed"
fi


info "Ready. From this repo, deploy selected groups with: tuckr set tmux starship opencode bashrc"
info "nvim is intentionally left to Omarchy/omarchy-nvim and is not managed here."
