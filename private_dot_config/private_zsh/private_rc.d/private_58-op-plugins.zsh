# ~/.config/zsh/rc.d/58-op-plugins.zsh
#
# 1Password CLI plugin aliases. Sourced after aliases/functions and before the
# plugin managers, matching the original load position.

# if op has plugins configured, source the file to pick up the aliases
if [ -f "${XDG_CONFIG_HOME}/op/plugins.sh" ]; then
    source "${XDG_CONFIG_HOME}/op/plugins.sh"
fi

# cmux's shell integration unaliases `claude` and replaces it with a function,
# again on the first prompt via its _cmux_fix_path precmd hook. Restore the op
# alias once that has run. cmux's claude shim stays first on PATH, so
# `op plugin run -- claude` still goes through cmux's wrapper.
_op_claude_realias() {
    (( ${precmd_functions[(I)_cmux_fix_path]} )) && return
    alias claude="op plugin run -- claude"
    add-zsh-hook -d precmd _op_claude_realias
}
autoload -Uz add-zsh-hook && add-zsh-hook precmd _op_claude_realias
