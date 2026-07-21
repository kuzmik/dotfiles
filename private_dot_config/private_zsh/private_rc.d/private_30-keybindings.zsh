# ~/.config/zsh/rc.d/30-keybindings.zsh
#
# Base keybindings. History-search bindings live in 65-hist-search (after atuin).

# go back to normal keybindings
# see https://stackoverflow.com/questions/23128353/zsh-shortcut-ctrl-a-not-working
bindkey -e

# fucking delete key
bindkey "^[[3~" delete-char
