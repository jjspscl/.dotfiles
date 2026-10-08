# growmodo dotfiles

On the `growmodo` branch, `Configs/alacritty/.config/alacritty/` preserves jjspscl's Alacritty appearance settings; the YAML is extended to launch tmux explicitly. The inspected source Zsh and Alacritty config files do not themselves declare auto-start. Alacritty 0.10.1 loads `alacritty.yml`; `alacritty.toml` remains the source account's separate font-only config and is not loaded by that version.

To link this configuration for the growmodo account:

```sh
mkdir -p ~/.config
ln -s "$HOME/.dotfiles/Configs/alacritty/.config/alacritty" "$HOME/.config/alacritty"
```

Install Meslo LG DZ Nerd Font for this account (the YAML uses it). The TOML uses its Mono variant. If `~/.config/alacritty` already exists, inspect and back it up before replacing it. The repository does not include font binaries.

## Zsh and tmux

`Configs/zshrc/.zshrc` mirrors jjspscl's Zsh setup, with the Linux-only Neovim path removed and the optional Volta path guarded. It requires Oh My Zsh and the `zsh-autosuggestions` plugin. `Configs/tmux/.tmux.conf` mirrors jjspscl's tmux settings and TPM plugin list. The `projs` shortcut enters `/Users/Shared/jjspscl/projects/growmodo/`, and `oc` launches the OpenCode 2 beta CLI (`opencode2`).

For the growmodo account, back up any existing `~/.zshrc` or `~/.tmux.conf` before linking, then link the tracked configs:

```sh
ln -s "$HOME/.dotfiles/Configs/zshrc/.zshrc" "$HOME/.zshrc"
ln -s "$HOME/.dotfiles/Configs/tmux/.tmux.conf" "$HOME/.tmux.conf"
mkdir -p "$HOME/.tmux/plugins"
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
```

Install runtime dependencies and the tracked tmux plugin list (skip any clone whose destination already exists):

```sh
brew list --versions tmux >/dev/null || brew install tmux
test -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" || git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
test -d "$HOME/.tmux/plugins/tpm" || git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
"$HOME/.tmux/plugins/tpm/bin/install_plugins"
```

The active Alacritty 0.10.1 YAML config launches `/opt/homebrew/bin/tmux new-session -A -s 0`; it creates session `0` if needed or attaches to it otherwise. The TOML file remains the source account's font-only config and is not loaded by Alacritty 0.10.1.

## OpenCode 2

OpenCode 2 beta installs as `opencode2` alongside V1's `opencode`. Install it per-user with:

```sh
npm install --global --prefix "$HOME/.local" --allow-scripts=@opencode-ai/cli @opencode-ai/cli@beta
```

The fresh global config is `Configs/opencode/.config/opencode/opencode.json`, containing only the official schema reference—no model, provider, or credentials. Link only this file so runtime/auth data remains outside the repo:

```sh
mkdir -p "$HOME/.config/opencode"
ln -s "$HOME/.dotfiles/Configs/opencode/.config/opencode/opencode.json" "$HOME/.config/opencode/opencode.json"
```

OpenCode 2 reads this same global config path. Connect a provider separately in the `opencode2` TUI with `/connect`; credentials are not stored in dotfiles. If the default service port is occupied, choose a free per-user port with `opencode2 service set port <port>`; this writes `~/.config/opencode/service.json`, which should remain local and untracked.

The `Configs/aerospace/.aerospace.toml` file mirrors jjspscl's AeroSpace workspace bindings. For the growmodo account, link it at the app's home-directory config path:

```sh
ln -s "$HOME/.dotfiles/Configs/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"
```

If `~/.aerospace.toml` exists already, inspect and back it up before replacing it. After linking, run `aerospace reload-config --dry-run` and then `aerospace reload-config` to apply it.
