# https://github.com/simnalamburt/.dotfiles/blob/master/.zshrc 을 많이 참고함

# zplug
autoload -U is-at-least
export ZPLUG_HOME=/usr/local/opt/zplug
if is-at-least 4.3.9 && [[ -f $ZPLUG_HOME/init.zsh ]]; then
    source $ZPLUG_HOME/init.zsh

    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions"
    ZSH_AUTOSUGGEST_USE_ASYNC=true
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "zsh-users/zsh-history-substring-search"
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    zplug "simnalamburt/shellder", as:theme

    zplug load
else
    PS1='%n@%m:%~%(!.#.$) '
fi

# shellder prompt without machine name
export DEFAULT_USER="$USER"

# ls colors
autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedxbagxcad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=30;46:tw=0;42:ow=30;43"
export TIME_STYLE="+%y%m%d"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# alias ls="ls --color=tty"
alias ls="ls -G"

#
# zsh-substring-completion
#
setopt complete_in_word
setopt always_to_end
WORDCHARS=''
zmodload -i zsh/complist

# Substring completion
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# disable ctrl + s which freeze the terminal
stty stop undef

# for safety
alias mv='mv -i'
alias cp='cp -i'

# zsh options
setopt auto_cd histignorealldups sharehistory
zstyle ':completion:*' menu select
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

#export TERM='screen-256color'
export TERM='xterm-256color'

alias benv27='source ~/.benv27/bin/activate'
alias benv3='source ~/.benv3/bin/activate'
alias mkvirtualenv3='mkvirtualenv --python=/usr/bin/python3.5'

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)

alias tmuxat='tmux attach -t'
alias tmuxatd='tmux attach-session -d -t'

# Virtualenvwrapper
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# set for irssi in screen-256color
alias irssi='TERM=screen-256color /usr/bin/irssi'

alias sl=ls


alias logcat='adb logcat -v threadtime | tee temp.logcat'

alias upgrade_all='sudo apt-get update && sudo apt-get upgrade'

[ -f ~/.profile ] && source ~/.profile
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# color settings for tldr
export TLDR_COLOR_BLANK="white"
export TLDR_COLOR_NAME="yellow bold"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="cyan"
export TLDR_COLOR_COMMAND="green"
export TLDR_COLOR_PARAMETER="white"

alias git=hub

# Local configs
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
