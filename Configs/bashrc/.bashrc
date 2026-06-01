# JP Omarchy/Arch bash config managed by Tuckr.
# Keeps Omarchy's default bash setup, then layers JP's portable shell niceties.

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions.
# Keep this near the top so JP overrides below win when names overlap.
if [[ -f "$HOME/.local/share/omarchy/default/bash/rc" ]]; then
  source "$HOME/.local/share/omarchy/default/bash/rc"
fi

# Hermes/Omarchy environment hook, if present.
if [[ -f "$HOME/.local/share/../bin/env" ]]; then
  source "$HOME/.local/share/../bin/env"
fi

export VOLTA_HOME="$HOME/.volta"
export GOROOT="$HOME/.local/go"
export GOPATH="$HOME/go"
export BUN_INSTALL="$HOME/.bun"
export KUBE_EDITOR="nvim"

# Path setup. Use a helper to avoid duplicates while preserving order.
path_prepend() {
  [[ -d "$1" ]] || return 0
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1${PATH:+:$PATH}" ;;
  esac
}

path_prepend "$HOME/bin"
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.cargo/bin"
path_prepend "$HOME/.local/nvim/bin"
path_prepend "$HOME/.opencode/bin"
path_prepend "$BUN_INSTALL/bin"
path_prepend "$VOLTA_HOME/bin"
path_prepend "$GOROOT/bin"
path_prepend "$GOPATH/bin"
path_prepend "/usr/local/bin"
export PATH

# Optional tmux auto-attach. Enable with: export JP_TMUX_AUTO_ATTACH=1
if [[ "${JP_TMUX_AUTO_ATTACH:-}" == "1" ]] \
  && command -v tmux >/dev/null 2>&1 \
  && [[ -z "${TMUX:-}" && -z "${VSCODE_PID:-}" && -z "${INTELLIJ_ENVIRONMENT_READER:-}" ]]; then
  if tmux has-session -t 0 2>/dev/null; then
    exec tmux attach-session -t 0
  else
    exec tmux new-session -s 0
  fi
fi

if [[ -n "${SSH_CONNECTION:-}" ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias vim="nvim"
alias lg="lazygit"
alias oc="opencode"
alias fd="fd"

# Optional tools.
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
command -v mise >/dev/null 2>&1 && eval "$(mise activate bash 2>/dev/null)"

# OpenClaw completions if present.
if [[ -f "$HOME/.openclaw/completions/openclaw.bash" ]]; then
  source "$HOME/.openclaw/completions/openclaw.bash"
elif [[ -f "$HOME/.openclaw/completions/openclaw.sh" ]]; then
  source "$HOME/.openclaw/completions/openclaw.sh"
fi

# Local secrets/env; never commit this file.
[[ -f "$HOME/.bashrc.secrets" ]] && source "$HOME/.bashrc.secrets"

# Starship prompt.
command -v starship >/dev/null 2>&1 && eval "$(starship init bash 2>/dev/null)"
