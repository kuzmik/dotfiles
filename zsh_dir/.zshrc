# ~/.zsh/.zshrc

### User configuration specific to nick
umask 077

eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ -f $(brew --prefix asdf)/libexec/asdf.sh ]]; then
  . $(brew --prefix asdf)/libexec/asdf.sh
fi

export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

alias bo='brew update && brew outdated'
alias grb='git fetch --all && git rebase -i origin/master'
alias lsl='ls -halG'
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias vg='rg --vimgrep'
alias vim='nvim'
alias wget='wget --no-hsts'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias k='kubectl'
alias kx='kubectx'
alias kn='kubens'
alias proxy.stg='kubectx gke_persona-web-staging_us-central1_persona-web-staging && kubens proxysql'
alias proxy.prd='kubectx gke_persona-web_us-central1_persona-web && kubens proxysql'

# work specific
alias dcom='docker compose'
alias cpw='cd ~/Code/persona-web'

export CLICOLOR=1
export EDITOR='nvim'
export GUI_EDITOR='subl'
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export HOMEBREW_NO_ENV_HINTS=1
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export RIPGREP_CONFIG_PATH='/Users/nick/.ripgreprc'
export SAVEHIST=1000000000
export WORDCHARS='*?[]~&;!$%^<>'

setopt AUTO_PUSHD               # Push the old directory onto the stack on cd.
setopt CDABLE_VARS              # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB            # Use extended globbing syntax.
setopt EXTENDED_HISTORY         # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS        # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE        # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS        # Do not write a duplicate event to the history file.
setopt PUSHD_IGNORE_DUPS        # Do not store duplicates in the stack.
setopt PUSHD_SILENT             # Do not print the directory stack after pushd or popd.
unsetopt CORRECT                # Spelling correction
unsetopt FLOW_CONTROL           # Ctrl+S and Ctrl+Q usually disable/enable tty input. This disables those inputs
unsetopt SHARE_HISTORY          # Don't share history between all sessions.

# go back to normal keybindings
# see https://stackoverflow.com/questions/23128353/zsh-shortcut-ctrl-a-not-working
bindkey -e

# sheldon plugin manager
if (( $+commands[sheldon] )); then
  if ! $(command -v _sheldon &> /dev/null) ; then
    eval "$(sheldon source)"
  fi
fi

# Load starship, for the ps1 prompt
if (( $+commands[starship] )); then
  if ! $(command -v _starship &> /dev/null) ; then
    eval "$(starship init zsh)"
  fi
fi

# Load all the completion stuff from a separate file
source $ZDOTDIR/completion.zsh
