# Ghostty Terminal Configuration

This directory contains configuration files for [Ghostty](https://ghostty.org/), a modern terminal emulator with excellent performance and features. These configuration files are designed to provide an experience similar to your previous Wezterm setup.

## Installation

1. Install Ghostty from https://ghostty.org/download or using a package manager

2. Create the Ghostty configuration directory:
   ```bash
   mkdir -p ~/.config/ghostty
   ```

3. Copy the configuration files:
   ```bash
   cp -r ./ghostty/* ~/.config/ghostty/
   ```

4. Make the editor fallback script executable:
   ```bash
   chmod +x ~/.config/ghostty/editor_fallback.sh
   ```

5. (Optional) Create a symlink to the editor fallback script in your path:
   ```bash
   mkdir -p ~/bin
   ln -s ~/.config/ghostty/editor_fallback.sh ~/bin/
   ```

## Key Features

- **Font Configuration**: Uses MonoLisa font with ligatures disabled for clear code viewing
- **Split Management**: Create and navigate splits with intuitive keyboard shortcuts
- **Transparency & Blur**: Provides the same aesthetics as your Wezterm setup
- **Custom File Handling**: The editor fallback script provides similar functionality to Wezterm's custom hyperlink handler
- **Key Bindings**: Mapped to match your Wezterm configuration as closely as possible

## Keyboard Shortcuts

The key bindings in this configuration are designed to match your Wezterm setup. See the main `config` file for the full list of keybindings.

## File Hyperlinks

Refer to `file_hyperlinks.md` for information on how to handle file URLs with Ghostty, including a solution for the editor fallback mechanism.

## Customization

Feel free to modify these configuration files to better suit your preferences. The Ghostty documentation is available at https://ghostty.org/docs/ for reference.

## Notes

- Ghostty may not support all features of Wezterm, but this configuration aims to provide a similar experience
- Some aspects of Wezterm (like custom Lua functions) are handled differently in Ghostty
- The included editor fallback script provides a similar functionality to the Wezterm hyperlinks.lua script