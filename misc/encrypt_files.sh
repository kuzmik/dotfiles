#!/bin/bash
set -o errtrace
set -o errexit
set -o nounset
set -o pipefail

# Encrypt certain files using my public key from 1Password
# Requires:
# - age (brew install age)
# - 1Password (brew install 1password)
# - 1Password CLI (brew install 1password-cli)

# encrypt the monolisa.tbz2 and Raycast.rayconfig files with my public key from 1Password
cat monolisa.tbz2 | age -e \
  --recipient="$(op read --account=my.1password.com 'op://personal/personal - ssh key/public key')" \
  -o monolisa.tbz2.age

cat Raycast.rayconfig | age -e \
  --recipient="$(op read --account=my.1password.com 'op://personal/personal - ssh key/public key')" \
  -o Raycast.rayconfig.age
