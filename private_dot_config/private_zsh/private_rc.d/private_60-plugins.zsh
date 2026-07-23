# ~/.config/zsh/rc.d/60-plugins.zsh
#
# Plugin managers and tool shell integrations.

# sheldon plugin manager
if (( $+commands[sheldon] )); then
  eval "$(sheldon source)"
fi

# Load starship, for the ps1 prompt
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# load direnv
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

# auto-reshim after any mise command that changes installed tools
if (( $+commands[mise] )); then
  mise() {
    command mise "$@"
    local ret=$?
    case "${1:-}" in
      install|uninstall|use|prune|upgrade|up)
        command mise reshim
        ;;
    esac
    return $ret
  }
fi

# fzf key-bindings: Ctrl-T (insert files), Alt-C (cd into subdir), Ctrl-R.
# Sourced BEFORE atuin on purpose so atuin re-binds Ctrl-R and wins it.
if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
fi

# Use atuin to save shell history
if (( $+commands[atuin] )); then
  eval "$(atuin init zsh --disable-up-arrow)"
fi
