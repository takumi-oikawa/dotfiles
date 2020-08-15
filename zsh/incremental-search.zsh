export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'

function fvim() {
    if git ls-files; then
        git ls-files 2>/dev/null | fzf -m --preview 'head -100 {}'
    else
        git tree 2>/dev/null | fzf -m --preview 'head -100 {}'
    fi
}

function fzf-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | eval $tac | awk '!a[$0]++' | fzf --query "$LBUFFER")
    CURSOR=$#BUFFER
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history


function fzf-cdr () {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    CURSOR=$#BUFFER
  fi
}
zle -N fzf-cdr
bindkey "^@" fzf-cdr


function fzf-ghq () {
  local selected_dir=$(ghq list -p | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-ghq
bindkey '^]' fzf-ghq

