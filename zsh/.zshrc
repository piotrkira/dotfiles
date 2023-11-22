HISTFILE=~/.zsh_history
SAVEHIST=1000000
HISTSIZE=1000000

setopt INC_APPEND_HISTORY

autoload -Uz compinit; compinit

alias vim='nvim'
alias ssh='TERM=screen-256color ssh'
alias tmux='TERM=screen-256color tmux'

source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/fzf/key-bindings.zsh

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

export LANG=en_US.UTF-8

eval "$(starship init zsh)"
