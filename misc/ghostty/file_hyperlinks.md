# File Hyperlinks in Ghostty

In Wezterm, you had a custom Lua script that handled opening files from terminals with `file-line-column://` URLs. Ghostty handles hyperlinks differently, and we need to adapt to its approach.

## How File Hyperlinks Work in Ghostty

1. Ghostty has built-in support for opening URLs with the `link-url = true` configuration option.

2. Unlike Wezterm, Ghostty doesn't have a direct equivalent to the custom Lua function that intercepted and handled `file-line-column://` URLs.

## Solutions for File Hyperlinks

### Option 1: Use shell scripts

Create a shell script that parses and opens the file URLs:

```bash
# Example script: ~/bin/open-file-url.sh
#!/bin/bash

# Extract path, line, and column from URL
url="$1"
file_path=$(echo "$url" | sed 's|file-line-column://||')

# Split into path:line:column
path=${file_path%%:*}
rest=${file_path#*:}
line=${rest%%:*}
column=${rest#*:}

# Open with your editor
cursor -g "$path:$line:$column"
```

Use this script with tools that generate hyperlinks.

### Option 2: Configure tools directly

Many tools can be configured to use different URL formats. For example:

1. For ripgrep, use `--hyperlink-format` to generate links compatible with your editor
2. For other tools, check their documentation for hyperlink formatting options

### Extending Ghostty (Future)

Ghostty is actively developed and may add more customization for hyperlinks in the future. Check the documentation and GitHub repository for updates.