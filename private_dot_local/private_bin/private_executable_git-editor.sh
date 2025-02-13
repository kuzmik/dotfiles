# ~/.local/bin/git-editor.sh

#!/bin/bash

# since cursor isnt installed in my devcontainers, use vim as the fallback editor.
if command -v cursor >/dev/null 2>&1; then
    exec cursor -w "$@"
else
    exec vim "$@"
fi
