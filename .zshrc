# brew first
export PATH=/usr/local/bin:$PATH

# gnu first
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gawk/libexec/gnubin:$PATH"

MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/gawk/libexec/gnuman:$MANPATH"

# XDG Base Directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# Add PATH
export PATH=$PATH:$HOME/dotfiles/scripts

# lesspipe
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS='-R'

# vim -> nvim
alias vim="TERM=xterm-256color nvim"

export LANG=ja_JP.UTF-8

# add cd hook and cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook && add-zsh-hook chpwd chpwd_recent_dirs
autoload -Uz colors && colors

# history
export HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE
setopt SHARE_HISTORY
export HISTSIZE=1000000
export SAVEHIST=1000000

# zle
bindkey -v
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^B" backward-char
bindkey -M viins "^D" delete-char-or-list
bindkey -M viins "^E" end-of-line
bindkey -M viins "^F" forward-char
bindkey -M viins "^G" send-break
bindkey -M viins "^H" backward-delete-char
bindkey -M viins "^K" kill-line
bindkey -M viins "^N" down-line-or-history
bindkey -M viins "^P" up-line-or-history
bindkey -M viins "^U" backward-kill-line
bindkey -M viins "^W" backward-kill-word

PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "

# completion
autoload -Uz compinit && compinit

# ignorecase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ignoreparent
zstyle ':completion:*' ignore-parents parent pwd ..

# complete command string after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# verbose
zstyle ':completion:*' verbose yes

# vcs_info
autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

########################################

setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob

########################################
# always --parent options
alias mkdir='mkdir -p'

# Enable command alias after sudo
alias sudo='sudo '

# rich ls
alias ll='ls -alhFG1v --color=auto --group-directories-first'

# git checkout incremental
alias fco="git branch | fzf | xargs git checkout"

# always colored grep
alias grep='grep --color=auto'

# always colored ls
alias ls='ls -F --color=auto'

#######################################

# fzf + ag configuration
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'

# fzf vim file open
function fvim() {
    if git ls-files; then
        git ls-files 2>/dev/null | fzf -m --preview 'head -100 {}'
    else
        git tree 2>/dev/null | fzf -m --preview 'head -100 {}'
    fi
}

# Incremental search history
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

# Incremental search recent dirs
function fzf-cdr () {
  local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    CURSOR=$#BUFFER
  fi
}
zle -N fzf-cdr
bindkey "^@" fzf-cdr

# fzf + ghq
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

# cd hook
chpwd() {
    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')
    if [ $ls_lines -lt 15 ] && [ $(pwd) != $HOME ]; then
        ls -G -F
    fi
}

# For building andriod
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk

# virtualenv wrapper
export WORKON_HOME=~/.virtualenvs

# java8
export JAVA_HOME=`/usr/libexec/java_home -v "1.8"`
PATH=${JAVA_HOME}/bin:${PATH}

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
