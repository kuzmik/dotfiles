# ~/.config/zsh/rc.d/58-op-plugins.zsh
#
# 1Password CLI plugin aliases. Sourced after aliases/functions and before the
# plugin managers, matching the original load position.

# if op has plugins configured, source the file to pick up the aliases
if [ -f "${XDG_CONFIG_HOME}/op/plugins.sh" ]; then
    source "${XDG_CONFIG_HOME}/op/plugins.sh"
fi
