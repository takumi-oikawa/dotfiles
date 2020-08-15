export PATH=/usr/local/bin:$PATH
export PATH=$PATH:$HOME/dotfiles/scripts

export DOTFILES_PATH=$HOME/dotfiles


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

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS='-R'

alias vim="TERM=xterm-256color nvim"

export LANG=ja_JP.UTF-8

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook && add-zsh-hook chpwd chpwd_recent_dirs
autoload -Uz colors && colors


export HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE
setopt SHARE_HISTORY
export HISTSIZE=1000000
export SAVEHIST=1000000


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


autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*' verbose yes


source $DOTFILES_PATH/zsh/prompt.zsh


setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt pushd_ignore_dups
setopt extended_glob


alias mkdir='mkdir -p'

alias sudo='sudo '

alias ll='ls -alhFG1v --color=auto --group-directories-first'

alias fco="git branch | fzf | xargs git checkout"

alias grep='grep --color=auto'

alias ls='ls -F --color=auto'

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


chpwd() {
    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')
    if [ $ls_lines -lt 15 ] && [ $(pwd) != $HOME ]; then
        ls -G -F
    fi
}

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk

export WORKON_HOME=~/.virtualenvs

export JAVA_HOME=`/usr/libexec/java_home -v "1.8"`
PATH=${JAVA_HOME}/bin:${PATH}

export PATH=$HOME/.nodebrew/current/bin:$PATH
