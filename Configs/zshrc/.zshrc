# Auto-attach to tmux session
if command -v tmux &>/dev/null && [[ -z "$TMUX" && -z "$VSCODE_PID" && -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then
  if tmux has-session -t 0 2>/dev/null; then
    exec tmux attach-session -t 0
  else
    exec tmux new-session -s 0
  fi
fi

# If you come from bash you might have to change your $PATH.
export VOLTA_HOME="$HOME/.volta"
export GOROOT="$HOME/.local/go"
export GOPATH="$HOME/go"
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$VOLTA_HOME/bin:$HOME/.cargo/bin:$GOROOT/bin:$GOPATH/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export KUBE_EDITOR="nvim"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""  # Using Starship prompt instead

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/.local/nvim/bin:$PATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim"
alias projs="cd /home/jjspscl/projects/cimic"
alias fd="fdfind"
alias lg="lazygit"
alias oc="opencode"
alias ocw="openclaw"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:/mnt/c/Users/$USER/AppData/Local/Android/Sdk/platform-tools"

export ANDROID_SDK_ROOT="$HOME/android-wsl"
export ANDROID_HOME="$ANDROID_SDK_ROOT"
export PATH="$HOME/android-wsl/platform-tools:$PATH"
eval "$(mise activate zsh 2>/dev/null)"

# opencode
export PATH=$HOME/.opencode/bin:$PATH

# OpenClaw Completion
if [ -f "$HOME/.openclaw/completions/openclaw.zsh" ]; then
  source "$HOME/.openclaw/completions/openclaw.zsh"
fi
export VIMRUNTIME="$HOME/.local/nvim/share/nvim/runtime"

# MCP server API keys (used by opencode.json via {env:} interpolation)
# Loaded from a local-only file — never commit real tokens
[[ -f ~/.zshrc.secrets ]] && source ~/.zshrc.secrets

# Starship prompt
eval "$(starship init zsh 2>/dev/null)"

# Playwright MCP Bridge extension token (WSL2 → Windows browser)
# Loaded from ~/.zshrc.secrets

# opencode
export PATH=/home/jjspscl/.opencode/bin:$PATH

# VS Code (Windows) in WSL
export PATH="$PATH:/mnt/c/Users/jpascual/AppData/Local/Programs/Microsoft VS Code/bin"
