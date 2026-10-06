# growmodo dotfiles

On the `growmodo` branch, `Configs/alacritty/.config/alacritty/` contains a copy of the jjspscl account's Alacritty configuration. Both source files are preserved: Alacritty 0.10.1 loads `alacritty.yml`; `alacritty.toml` is the source account's separate font-only config and is not loaded by that version.

To link this configuration for the growmodo account:

```sh
mkdir -p ~/.config
ln -s "$HOME/.dotfiles/Configs/alacritty/.config/alacritty" "$HOME/.config/alacritty"
```

Install Meslo LG DZ Nerd Font for this account (the YAML uses it). The TOML uses its Mono variant. If `~/.config/alacritty` already exists, inspect and back it up before replacing it. The repository does not include font binaries.

The `Configs/aerospace/.aerospace.toml` file mirrors jjspscl's AeroSpace workspace bindings. For the growmodo account, link it at the app's home-directory config path:

```sh
ln -s "$HOME/.dotfiles/Configs/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"
```

If `~/.aerospace.toml` exists already, inspect and back it up before replacing it. After linking, run `aerospace reload-config --dry-run` and then `aerospace reload-config` to apply it.
