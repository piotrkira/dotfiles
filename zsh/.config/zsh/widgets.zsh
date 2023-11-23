function _ssh-fzf () {
  local selected_host=$(rg "Host " ~/.ssh/config | cut -b 6- | fzf --reverse --query "$LBUFFER")
  if [ -n "$selected_host" ]; then
    BUFFER="ssh ${selected_host}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N _ssh-fzf
bindkey '^\' _ssh-fzf
