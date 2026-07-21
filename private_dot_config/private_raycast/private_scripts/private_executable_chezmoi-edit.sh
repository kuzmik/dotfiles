#!/bin/bash
set -Eeuo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Chezmoi - Edit
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Edit Chezmoi dotfiles repo
# @raycast.author Nick Kuzmik
# @raycast.authorURL https://raycast.com/kuzmik

chezmoi edit
