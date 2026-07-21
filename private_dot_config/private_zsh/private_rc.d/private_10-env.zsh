# ~/.config/zsh/rc.d/10-env.zsh
#
# Interactive-only environment. Everything else (locale, EDITOR, colors,
# homebrew flags, SHM_DIR, telemetry opt-outs, work exports) lives in ~/.zshenv
# so non-interactive shells, scripts, and GUI apps see it too.

export HISTORY_IGNORE='(ls|cd|cd -|pwd|exit|date|* --help)'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"

HISTSIZE=50000
SAVEHIST=1000000000
WORDCHARS="*?[]~&;!$%^<>"
