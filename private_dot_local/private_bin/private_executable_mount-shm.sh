#!/bin/bash
set -eou pipefail

# mount (and create) a tmpfs backed shm directory at $SHM_DIR
# will error if $SHM_DIR is not set (on purpose). this is set
# in my ~/.zshenv file

# directory doesnt exist, so just mkdir -p it... although it
# should exist if chezmoi is doing its job properly
if [ ! -d "$SHM_DIR" ]; then
  mkdir -p "$SHM_DIR"
fi

# check to see if the directory is mounted already
if mount | grep "$SHM_DIR" > /dev/null; then
  echo "==> tmpfs is already mounted at \$SHM_DIR ($SHM_DIR)"
  exit 0
fi

echo "==> Mounting tmpfs at \$SHM_DIR ($SHM_DIR)"
sudo mount_tmpfs -s 100m "$SHM_DIR"
