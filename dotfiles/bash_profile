umask 077

shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'
export CLICOLOR='1'
export RIPGREP_CONFIG_PATH="/Users/kuzmik/.ripgreprc"

alias ls='ls -G'  # OS-X SPECIFIC - the -G command in OS-X is for colors, in Linux it's no groups
export LSCOLORS="gxDxFxdxCxExExhbadgxgx"

# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[1;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'

# Opt out of homebrew analytics collection
export HOMEBREW_NO_ANALYTICS=1

export SSH_AUTH_SOCK=$(ls -1t $(find /tmp/* -type s -maxdepth 1 -name 'Listeners' 2>/dev/null) | head -n 1)

# Number of lines to keep in the history file
export HISTSIZE=100000000000
# bash history is timestamped as YYYY-MM-DD HH:MM:SS
export HISTTIMEFORMAT='%F %T '
# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups
# ... and ignore same successive entries.
export HISTCONTROL=ignoreboth



# load the bash completions
if [[ -d $HOME/.bash_completion.d ]]; then
  for i in $(LC_ALL=C command ls "$HOME/.bash_completion.d"); do
    source "$HOME/.bash_completion.d/$i"
  done
fi
unset i

if [[ -n $(which brew) && -f $(brew --prefix)/etc/bash_completion ]]; then
  . $(brew --prefix)/etc/bash_completion
fi

## Setup the git crap

# In case the user does not have git completion
function __git_ps1() {
  echo ''
}

source /usr/local/etc/bash_completion.d/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=true

__prompt_command() {
  local curr_exit="$?"
  PS1="\A <\[${COLOR_CYAN}\]\u\[${COLOR_NC}\]@\[${COLOR_CYAN}\]\h\[${COLOR_NC}\]:\[${COLOR_LIGHT_BLUE}\]\W\[${COLOR_LIGHT_CYAN}\]\$(__git_ps1 \"(%s)\")"
  if [ "$curr_exit" != 0 ]; then
    PS1="$PS1 \[${COLOR_LIGHT_RED}\]\$\[${COLOR_NC}\] > "
  else
    PS1="$PS1 \[${COLOR_LIGHT_GREEN}\]\$\[${COLOR_NC}\] > "
  fi
}

PROMPT_COMMAND=__prompt_command
export PS2='> '
export PS3='#? '
export PS4='+ '

[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

eval "$(rbenv init -)"

export GOPATH="/Users/kuzmik/Development/go"
export PATH="$PATH:$GOPATH/bin"
export RANGE_HOST=grange.sso.global.square
export RANGE_PORT=443
export RANGE_SSL=1

# make sure ssh-agent is running
if ! pgrep -u kuzmik ssh-agent >/dev/null
then
  ssh-agent > ~/.ssh/agent_env
fi
  . ~/.ssh/agent_env > /dev/null

# set a tab title
function title {
    echo -ne "\033]0;"$*"\007"
}

# Python env stuff
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
# export WORKON_HOME=$HOME/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kuzmik/Code/gcloud/google-cloud-sdk/path.bash.inc' ]; then . '/Users/kuzmik/Code/gcloud/google-cloud-sdk/path.bash.inc'; fi
