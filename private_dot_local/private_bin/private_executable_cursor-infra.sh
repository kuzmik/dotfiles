#!/bin/bash
set -o errtrace
set -o errexit
set -o nounset
set -o pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Cursor - Persona Infrastructure
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🏗️

# Documentation:
# @raycast.description Open Cursor in the Persona Infrastructure repo
# @raycast.author kuzmik
# @raycast.authorURL https://raycast.com/kuzmik

/usr/local/bin/cursor ~/Code/persona-infrastructure

