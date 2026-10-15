# ~/.config/zsh/rc.d/85-auto-completion.zsh
#
# On tab for a command with no completion, probe it for a zsh completion
# generator and cache the result in $ZDOTDIR/completions (on fpath, see 80).
# Needs compinit, so it runs after 80.
#
# Delete $ZDOTDIR/completions/.none/<cmd> to retry a command that failed.

typeset -g _AUTOCOMP_DIR="$ZDOTDIR/completions"

# Never run these, not even with --help.
typeset -ga _AUTOCOMP_DENY=(
  rm rmdir unlink shred srm mv cp ln dd truncate mkfs diskutil fdisk newfs
  chmod chown chgrp kill killall pkill shutdown reboot halt sudo su doas
  launchctl nvram csrutil tmutil
)

# _autocomp_generate <cmd>: write _<cmd> into the cache dir. Status 0 on success.
_autocomp_generate() {
  local cmd=$1 sub out
  (( $+commands[$cmd] )) || return 1
  (( ${_AUTOCOMP_DENY[(Ie)$cmd]} )) && return 1

  # Only probe commands that advertise completion support.
  timeout 2 $cmd --help </dev/null 2>&1 | command grep -qi completion || return 1

  for sub in "completion zsh" "completion -s zsh" "completions zsh" "--completion zsh" "--completions zsh"; do
    out=$(timeout 3 $cmd ${=sub} </dev/null 2>/dev/null) || continue
    [[ ${out%%$'\n'*} == '#compdef'* ]] || continue
    print -r -- "$out" >| "$_AUTOCOMP_DIR/_$cmd"
    return 0
  done
  return 1
}

_auto_complete() {
  local cmd=$words[1]
  if [[ -n $cmd && ! -e $_AUTOCOMP_DIR/.none/$cmd ]]; then
    mkdir -p $_AUTOCOMP_DIR/.none
    if _autocomp_generate $cmd; then
      autoload -Uz _$cmd
      compdef _$cmd $cmd
      _$cmd "$@" && return 0
    else
      : >| $_AUTOCOMP_DIR/.none/$cmd
    fi
  fi
  _default "$@"
}

compdef _auto_complete -default-
