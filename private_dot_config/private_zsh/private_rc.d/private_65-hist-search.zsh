# ~/.config/zsh/rc.d/65-hist-search.zsh
#
# Prefix history search on Up/Down. These need to go after atuin init (60).

# up and down search history when there is a character on the line.
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search    # Up
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search  # Down
bindkey "^[OB" down-line-or-beginning-search
