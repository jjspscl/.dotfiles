#!/bin/sh
set -eu

if [ -d "$HOME/.oh-my-zsh" ]; then
  plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  if [ ! -d "$plugin_dir" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir"
  fi
else
  printf '%s\n' "Oh My Zsh is not installed; skipping zsh-autosuggestions hook."
fi
