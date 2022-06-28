# ~/.zshenv

# Dont read global configs
unsetopt GLOBAL_RCS

export ZDOTDIR="/Users/nick/.zsh"

if [[ -f "$HOME/.zshenv.custom" ]]; then
  . $HOME/.zshenv.custom
fi
