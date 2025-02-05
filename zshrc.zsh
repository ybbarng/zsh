zsh_start=`perl -MTime::HiRes=time -e 'printf "%.9f\n", time'`
# zinit
autoload -U is-at-least

case `uname` in
  Darwin)
    # commands for OS X go here
    export ZPLUG_HOME=/usr/local/opt/zplug
  ;;
  Linux)
    # commands for Linux go here
    export ZPLUG_HOME=~/.zplug
  ;;
  FreeBSD)
    # commands for FreeBSD go here
  ;;
esac

if is-at-least 4.3.9 && [[ -f $ZPLUG_HOME/init.zsh ]]; then
    source $ZPLUG_HOME/init.zsh

    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-history-substring-search"
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug load

    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    ZSH_AUTOSUGGEST_USE_ASYNC=true
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)

else
    PS1='%n@%m:%~%(!.#.$) '
fi

# ls colors
autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedxbagxcad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=30;46:tw=0;42:ow=30;43"
export TIME_STYLE="+%y%m%d"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
case `uname` in
  Darwin)
    # commands for OS X go here
    alias ls="ls -G"
  ;;
  Linux)
    # commands for Linux go here
    alias ls="ls --color=tty"
  ;;
  FreeBSD)
    # commands for FreeBSD go here
  ;;
esac

# prefer https://github.com/Peltoche/lsd
if command -v lsd >/dev/null 2>&1; then
  alias ls="lsd"
fi

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
setopt HIST_IGNORE_SPACE
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
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
[ -f /usr/local/bin/virtualenvwrapper_lazy.sh ] && source /usr/local/bin/virtualenvwrapper_lazy.sh

alias sl=ls


alias logcat='adb logcat -v threadtime | tee temp.logcat'

alias upgrade_all='sudo apt-get update && sudo apt-get upgrade'

# color settings for tldr
export TLDR_COLOR_BLANK="white"
export TLDR_COLOR_NAME="yellow bold"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="cyan"
export TLDR_COLOR_COMMAND="green"
export TLDR_COLOR_PARAMETER="white"

# interpret color characters
export LESS='-R'

## if hub is exists
#if type "hub" > /dev/null; then
#    alias git=hub
#fi

# br: https://dystroy.org/broot/
[ -f /Users/ybbarng/Library/Preferences/org.dystroy.broot/launcher/bash/br ] && source /Users/ybbarng/Library/Preferences/org.dystroy.broot/launcher/bash/br

# Prevent use git checkout
function git {
  if [[ "$1" == "checkout" ]]; then
    RED='\033[0;31m'
    NC='\033[0m'
    echo -e "${RED}아재야 switch/restore를 써${NC}"
    return 1
  else
    command git "$@"
  fi
}

# nvm 설정
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# nvm을 자동으로 확인 및 적용, 없으면 설치까지 자동대응
# place this after nvm initialization!
# https://github.com/nvm-sh/nvm#zsh
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Local configs
[ -f ~/.profile ] && source ~/.profile
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

## Use starship: https://starship.rs/
eval "$(starship init zsh)"
zsh_end=`perl -MTime::HiRes=time -e 'printf "%.9f\n", time'`
zsh_runtime=`printf "%.3f\n" $((zsh_end-zsh_start))`
echo 'Loading .zshrc takes ' $zsh_runtime 'ms'
