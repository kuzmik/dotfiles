#!/bin/bash

# editor_fallback.sh
#
# This script checks for the existence of preferred editors in order and uses
# the first one that exists. This script can be used with Ghostty hyperlinks
# or other applications that need to open files in an editor.
#
# Usage: editor_fallback.sh /path/to/file[:line[:column]]

# Parse input
input_file="$1"

# Extract path, line, and column from the input
if [[ "$input_file" =~ ":" ]]; then
  path=$(echo "$input_file" | cut -d':' -f1)
  line=$(echo "$input_file" | cut -d':' -f2)
  column=$(echo "$input_file" | cut -d':' -f3)

  # If line or column are empty, set them to default values
  line=${line:-1}
  column=${column:-1}

  formatted_args="$path:$line:$column"
else
  path="$input_file"
  formatted_args="$path"
fi

# Check for editors in order of preference
if [ -x "/usr/local/bin/cursor" ]; then
  # Cursor is available
  exec /usr/local/bin/cursor -g "$formatted_args"
elif [ -x "/opt/homebrew/bin/subl" ]; then
  # Sublime Text is available
  exec /opt/homebrew/bin/subl "$formatted_args"
else
  # Fallback to vim
  if [[ "$input_file" =~ ":" ]]; then
    # Vim needs different format for line numbers
    exec vim "+$line" "$path"
  else
    exec vim "$path"
  fi
fi