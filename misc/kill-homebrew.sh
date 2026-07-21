#!/bin/bash
set -Eeuo pipefail

# Uninstall Homebrew to test fresh installs
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

sudo rm -rf /opt/homebrew/
