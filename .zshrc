export LANG=en_US.UTF-8

export PATH=/usr/local/bin:$PATH

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

export DOTFILES_PATH=$HOME/dotfiles


setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt pushd_ignore_dups
setopt extended_glob


export HISTFILE=$HOME/.zsh_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_no_store
setopt share_history
export HISTSIZE=10000
export SAVEHIST=10000


autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*' verbose yes


autoload -Uz chpwd_recent_dirs cdr add-zsh-hook && add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-max 1000
zstyle ':chpwd:*' recent-dirs-file "$XDG_CACHE_HOME/chpwd-recent-dirs"


source $DOTFILES_PATH/zsh/prefer-gnu.zsh
source $DOTFILES_PATH/zsh/line-editor.zsh
source $DOTFILES_PATH/zsh/appearance.zsh
source $DOTFILES_PATH/zsh/incremental-search.zsh
source $DOTFILES_PATH/zsh/aliases.zsh
[ -f $DOTFILES_PATH/zsh/env.zsh ] && source $DOTFILES_PATH/zsh/env.zsh
fpath+=$HOME/.zsh_functions
