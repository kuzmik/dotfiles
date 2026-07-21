# ~/.config/zsh/rc.d/00-path.zsh
#
# Re-assert PATH for interactive shells. The canonical PATH (mise shims,
# ~/.local/bin, gcloud SDK) is built in ~/.zshenv so non-interactive shells and
# scripts get it too; this re-prepends our dirs so they win after macOS
# /etc/zprofile's path_helper reorders PATH for login shells. typeset -U dedupes.

export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH:/usr/local/bin"
typeset -U path PATH
