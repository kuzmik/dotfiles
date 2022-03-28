#!/usr/bin/bash

set -eux
set -o pipefail

## Actual dotfiles
# .bashrc and .profile are symlinks to .bash_profile
for f in aliases bash_history bash_profile gemrc gitconfig railsrc ripgreprc; do
  cat "~/.$f" > dotfiles/$f
done

## Brew packages
brew bundle dump --all --describe --force

## Sublime Text 3 packages and settings. Boxy and it's addons are gonzo, so make sure to keep a copy of them.
mkdir -p Sublime/Packages/User

# copy over installed packages because apparently packages can vanish, see boxy as an example
cp -rf "~/Library/ApplicationSupport/Sublime Text 3/Installed Packages" Sublime

# copy over boxy extra addons
cp -rf "~/Library/ApplicationSupport/Sublime Text 3/Packages/Boxy Theme Addon - Mono File Icons" Sublime/Packages
cp -rf "~/Library/ApplicationSupport/Sublime Text 3/Packages/Boxy Theme Addon - Unified Mode" Sublime/Packages

# copy over the sublime settings from user
for f in "Package Control.sublime-settings" "Preferences.sublime-settings" "Default (OSX).sublime-keymap"; do
  cp -rf "~/Library/ApplicationSupport/Sublime Text 3/Packages/User/$f" Sublime/Packages/User
done
