HISTFILE=~/.zsh_history
SAVEHIST=1000000
HISTSIZE=1000000

setopt INC_APPEND_HISTORY

autoload -Uz compinit; compinit

alias vim='nvim'
alias vi='nvim'
alias ssh='TERM=screen-256color ssh'
alias tmux='TERM=screen-256color tmux'

source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/fzf/key-bindings.zsh

source ~/.config/zsh/widgets.zsh

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

export LANG=en_US.UTF-8

export FZF_DEFAULT_OPTS="--height 40% --info inline"
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="fd"

eval "$(starship init zsh)"
