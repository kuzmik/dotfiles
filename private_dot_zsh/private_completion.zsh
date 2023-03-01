# ~/.zsh/completions.zsh

# +---------+
# | General |
# +---------+

# Load more completions
fpath=(
  /opt/homebrew/completions/zsh
  /opt/homebrew/share/zsh/site-functions
  $fpath
)

# Should be called before compinit
zmodload zsh/complist

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xi' vi-insert                      # Insert
bindkey -M menuselect '^xh' accept-and-hold                # Hold
bindkey -M menuselect '^xn' accept-and-infer-next-history  # Next
bindkey -M menuselect '^xu' undo                           # Undo

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

compdef vman="man"

# +---------+
# | Options |
# +---------+

# setopt GLOB_COMPLETE      # Show autocompletion menu with globs
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# +---------+
# | zstyles |
# +---------+

# zstyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZDOTDIR/zcompcache"

# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:complete:git:argument-1:' tag-order !aliases

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' keep-prefix true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# 1password cli
if (( $+commands[op] )); then
  if ! $(command -v _op &> /dev/null) ; then
    eval "$(op completion zsh)"; compdef _op op
  fi
fi

# Krew
if (( $+commands[kubectl-krew] )); then
  export PATH="${PATH}:${HOME}/.krew/bin"
  eval "$(kubectl krew completion zsh)"
  compdef _krew kubectl-krew
fi

# I don't know why I need to manually source this. it's stupid and dumb.
if [ -d /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]; then
  . /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
  . /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

# ps/kill completion
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# Homebrew
zstyle ':fzf-tab:complete:brew-(install|uninstall|search|info):*-argument-rest' fzf-preview 'brew info $word'

# env vars
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

### DON'T DEAD, OPEN INSIDE
# # Commenting this out for now, it's more annoying than anything
# # Setup fzf to use ripgrep and bat, if possible
# if (( $+commands[fzf] )); then
#   if (( $+commands[rg] )); then
#     if command -v rg >/dev/null 2>&1; then
#       export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden --follow"
#     fi
#   fi

#   if (( $+commands[bat] )); then
#     if command -v bat >/dev/null 2>&1; then
#       export FZF_DEFAULT_OPTS='--inline-info --multi --reverse --preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500"'
#       export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
#       export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {}"
#     fi
#   fi
# fi

# # fzf-tab zsh plugin configuration

# directories and files
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -l --color=always --no-icons $realpath'
# zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
# zstyle ':fzf-tab:complete:ls:*' fzf-preview 'exa -l --color=always --no-icons $realpath'
# zstyle ':fzf-tab:complete:ls:*' popup-pad 30 0
# zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --style=numbers,changes --wrap never --color always {} || cat {}'
# zstyle ':fzf-tab:complete:*:*' fzf-preview 'LESSOPEN="|/Users/nick/.local/bin/lessfilter %s" less ${(Q)realpath}'