# ~/.zsh/.zshrc

### User configuration specific to nick
umask 077

eval "$(/opt/homebrew/bin/brew shellenv)"

. $(brew --prefix asdf)/libexec/asdf.sh

alias l="ls -alG"
alias vg='rg --vimgrep'
alias bo='brew update && brew outdated'
alias grb='git fetch --all && git rebase -i origin/master'
alias dcom='docker compose'
alias cpw='cd ~/Code/persona-web'
alias cat='bat'

export EDITOR='vim'
export CLICOLOR=1
export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

export PATH="/opt/homebrew/opt/python@3.10/bin:$HOME/.local/bin:$PATH"
export HOMEBREW_NO_ENV_HINTS=1
export RIPGREP_CONFIG_PATH='/Users/nick/.ripgreprc'
export HISTFILE="$ZDOTDIR/history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000

setopt AUTO_PUSHD               # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS        # Do not store duplicates in the stack.
setopt PUSHD_SILENT             # Do not print the directory stack after pushd or popd.

setopt CDABLE_VARS              # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB            # Use extended globbing syntax.
unsetopt CORRECT                # Spelling correction

setopt EXTENDED_HISTORY         # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS        # Do not display a previously found event.
setopt HIST_IGNORE_SPACE        # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS        # Do not write a duplicate event to the history file.
unsetopt SHARE_HISTORY          # Don't share history between all sessions.

unsetopt FLOW_CONTROL           # Ctrl+S and Ctrl+Q usually disable/enable tty input. This disables those inputs

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