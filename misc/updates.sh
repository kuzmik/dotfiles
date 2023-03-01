#!/bin/env bash
set -o errtrace
set -o errexit
set -o nounset
set -o pipefail

# Update homebrew
if [[ -x $(command -v brew) ]]; then
  echo "=> brew: running update"
  brew update

  echo "=> brew: running upgrade"
  brew upgrade

  echo "=> brew: running cleanup"
  brew cleanup
fi

# Check for macos updates
if [[ -x $(command -v softwareupdate) ]]; then
  echo "=> softwareupdate: installing macOS software updates"
  softwareupdate  softwareupdate --all --install --force --verbose
fi

# Check for available mac app store upgrades, if `mas` is installed
if [[ -x $(command -v msas) ]]; then
  echo "=> mas: checking for outdated apps"
  mas outdated

  # TODO someday: only run this if there are outdated apps from the previous step
  # does mas exit with something other than 0 on outdated apps?
  # 13:01 <nick@arcadia:chezmoi(master)(✘?) $ > mas outdated ; echo $?
  # 0

  echo "=> mas: upgrading apps"
  mas upgrade
fi

# Update rtx plugins
if [[ -x $(command -v rtx) ]]; then
  echo "=> rtx: updating all plugins"
  rtx plugin update --all > /dev/null 2>&1
  echo "=> rtx: plugins updated"
fi
