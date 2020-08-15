export PATH=/usr/local/bin:$PATH
export PATH=$PATH:$HOME/dotfiles/scripts

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

export DOTFILES_PATH=$HOME/dotfiles

source $DOTFILES_PATH/zsh/prefer-gnu.zsh

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

source $DOTFILES_PATH/zsh/incremental-search.zsh


[ -f $DOTFILES_PATH/zsh/env.zsh ] && source $DOTFILES_PATH/zsh/env.zsh
