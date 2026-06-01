# JP Omarchy Dotfiles

This branch is JP's Omarchy/Arch setup, based on Omarchy and aligned with the useful parts of the `leighton-pc` dotfiles branch.

Omarchy itself is a beautiful, modern & opinionated Linux distribution by DHH. Read more at [omarchy.org](https://omarchy.org).

## What is aligned from `leighton-pc`

The `leighton-pc` branch is a Tuckr-managed WSL-style setup. This `omarchy` branch keeps the Omarchy/Arch structure intact and ports only the portable pieces:

| Area | Status | Notes |
| --- | --- | --- |
| tmux | aligned | `Ctrl-s` prefix, vi pane nav, repeatable window nav, current-directory splits, OSC52/passthrough clipboard, TPM, `tmux-sm`, Kanagawa minimal status |
| Starship | aligned | Kanagawa Dragon palette and richer prompt copied from `leighton-pc` |
| OpenCode | aligned | Agent config, TUI config, Kanagawa transparent theme, and Tamagui skill |
| bash | aligned | Omarchy-native `.bashrc`; ports the useful portable shell setup to JP's current shell with WSL paths removed; tmux auto-attach enabled for real terminals unless explicitly disabled |
| nvim | intentionally not aligned | Omarchy's `omarchy-nvim` / system Neovim remains the source of truth |

Do not merge `leighton-pc` directly into this branch: it deletes a large amount of Omarchy structure (`bin/`, `install/`, `config/`, `default/`, `themes/`, migrations, etc.). Cherry-pick/port individual config ideas instead.

## Repository layout

Omarchy-native config paths remain in place:

```text
config/tmux/tmux.conf
config/starship.toml
config/opencode/opencode.json
config/opencode/tui.json
config/opencode/themes/kanagawa-transparent.json
config/opencode/skills/tamagui.md
```

Tuckr groups are also provided for direct dotfile deployment:

```text
Configs/tmux/.tmux.conf
Configs/starship/.config/starship.toml
Configs/opencode/.config/opencode/...
Configs/bashrc/.bashrc
Configs/bashrc/.bashrc.secrets.example
Hooks/tmux/pre.sh
```

## Install / verify on Omarchy or Arch

Install core dependencies and Tuckr:

```bash
./install-arch.sh
```

Or manually:

```bash
sudo pacman -S --needed git curl tmux starship lazygit opencode rust
cargo install tuckr
```

TPM is required for tmux plugins:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Tuckr is installed at:

```text
~/.cargo/bin/tuckr
```

Make sure `~/.cargo/bin` is on `PATH`.

## Deploy with Tuckr

From this repo:

```bash
cd ~/.local/share/omarchy

tuckr set tmux starship opencode bashrc
```

To deploy selectively:

```bash
tuckr set tmux
tuckr set starship
tuckr set opencode
tuckr set bashrc
```

To inspect status:

```bash
tuckr status
```

## tmux notes

Prefix:

```text
Ctrl-s
```

Key bindings:

| Key | Action |
| --- | --- |
| `prefix + r` | reload `~/.tmux.conf` |
| `prefix + h/j/k/l` | move between panes |
| `prefix + n/p` | next/previous window, repeatable |
| `prefix + "` | vertical split in current directory |
| `prefix + %` | horizontal split in current directory |
| `prefix + c` | new window in current directory |
| `prefix + S` | tmux session manager (`tmux-sm`) |
| `prefix + I` | install TPM plugins |

First run inside tmux:

```text
Ctrl-s + I
```

## bash notes

This branch keeps bash as JP's Omarchy login shell and ports the useful portable shell setup. The managed `.bashrc` sources Omarchy's default bash config first, then applies JP-specific additions.

It includes:

- Omarchy default bash aliases/functions
- `vim=nvim`
- `lg=lazygit`
- `oc=opencode`
- mise activation when available
- Bun/Volta/Go path setup
- OpenClaw bash completions when present
- Starship prompt when available
- local-only secrets loaded from `~/.bashrc.secrets`

Tmux auto-attach is enabled by default for real interactive terminal sessions. Disable it only if wanted:

```bash
export JP_TMUX_AUTO_ATTACH=0
```

New interactive bash terminals will attach/create tmux session `0` when not already inside tmux. Non-TTY shells and editor-integrated shells are skipped.

## OpenCode notes

OpenCode is configured with:

- `build` default agent
- `plan`
- `tester`
- `product-manager`
- `code-reviewer`
- Kanagawa transparent TUI theme
- Tamagui skill

Local secrets/API keys should live outside git, usually in shell env or `~/.bashrc.secrets`.

## nvim policy

This branch intentionally does not deploy `leighton-pc`'s Neovim config.

Reason: this machine uses Omarchy/Arch Neovim (`omarchy-nvim` and system `nvim`), and replacing it with the WSL Kickstart setup could conflict with Omarchy conventions.

## License

Omarchy is released under the [MIT License](https://opensource.org/licenses/MIT). JP-specific dotfile additions are personal-use configuration.
