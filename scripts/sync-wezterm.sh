#!/bin/bash
# Copy the WezTerm config from this repo to the Windows user profile.
# WezTerm runs on Windows, so it can't follow a WSL symlink reliably
# (breaks if WSL isn't running yet). Re-run after editing the config.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/Configs/wezterm/.config/wezterm/wezterm.lua"

if ! grep -qi microsoft /proc/version 2>/dev/null; then
  echo "[!] Not running under WSL — skipping WezTerm sync"
  exit 0
fi

win_home="$(wslpath "$(cmd.exe /c 'echo %USERPROFILE%' 2>/dev/null | tr -d '\r')")"
dest_dir="$win_home/.config/wezterm"
mkdir -p "$dest_dir"

# Keep a one-time backup of any pre-existing, differing config
if [ -f "$dest_dir/wezterm.lua" ] && ! cmp -s "$SRC" "$dest_dir/wezterm.lua" && [ ! -f "$dest_dir/wezterm.lua.bak" ]; then
  cp "$dest_dir/wezterm.lua" "$dest_dir/wezterm.lua.bak"
fi

cp "$SRC" "$dest_dir/wezterm.lua"
echo "[✓] WezTerm config synced to $dest_dir/wezterm.lua"
