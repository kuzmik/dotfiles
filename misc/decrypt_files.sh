#!/bin/bash
set -Eeuo pipefail

# Encrypt certain files using my public key from 1Password
# Requires:
# - age (brew install age)
# - 1Password (brew install 1password)
# - 1Password CLI (brew install 1password-cli)

op read --account=my.1password.com 'op://personal/personal - ssh key/private key' | \
  age -d -i - Raycast.rayconfig.age > Raycast.rayconfig
