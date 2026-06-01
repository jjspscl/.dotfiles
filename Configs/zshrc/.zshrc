# JP Omarchy/Arch zsh config managed by Tuckr.
# Derived from leighton-pc, with WSL-specific paths removed.

export VOLTA_HOME="$HOME/.volta"
export GOROOT="$HOME/.local/go"
export GOPATH="$HOME/go"
export BUN_INSTALL="$HOME/.bun"
export KUBE_EDITOR="nvim"

path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.local/nvim/bin"
  "$HOME/.opencode/bin"
  "$BUN_INSTALL/bin"
  "$VOLTA_HOME/bin"
  "$GOROOT/bin"
  "$GOPATH/bin"
  /usr/local/bin
  $path
)
export PATH

# Optional tmux auto-attach. Enable with: export JP_TMUX_AUTO_ATTACH=1
if [[ "$JP_TMUX_AUTO_ATTACH" == "1" ]] && command -v tmux &>/dev/null && [[ -z "$TMUX" && -z "$VSCODE_PID" && -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then
  if tmux has-session -t 0 2>/dev/null; then
    exec tmux attach-session -t 0
  else
    exec tmux new-session -s 0
  fi
fi

# Oh My Zsh, if installed.
export ZSH="$HOME/.oh-my-zsh"
if [[ -d "$ZSH" ]]; then
  ZSH_THEME=""  # Starship prompt instead.
  DISABLE_AUTO_UPDATE="true"
  DISABLE_MAGIC_FUNCTIONS="true"
  DISABLE_COMPFIX="true"
  plugins=(git zsh-autosuggestions)
  source "$ZSH/oh-my-zsh.sh"
fi

if [[ -n "$SSH_CONNECTION" ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias vim="nvim"
alias lg="lazygit"
alias oc="opencode"
alias fd="fd"

# Optional tools.
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh 2>/dev/null)"

# OpenClaw completions if present.
if [ -f "$HOME/.openclaw/completions/openclaw.zsh" ]; then
  source "$HOME/.openclaw/completions/openclaw.zsh"
fi

# Local secrets/env; never commit this file.
[[ -f ~/.zshrc.secrets ]] && source ~/.zshrc.secrets

# Starship prompt.
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh 2>/dev/null)"
