# -? ~/.config/bat/config

# This is `bat`s configuration file. Each line either contains a comment or
# a command-line option that you want to pass to `bat` by default. You can
# run `bat --help` to get a list of all possible configuration options.

# Specify desired highlighting theme (e.g. "TwoDark"). Run `bat --list-themes`
# for a list of all available themes
--theme="Monokai Extended Origin"

# Enable this to use italic text on the terminal. This is not supported on all
# terminal emulators (like tmux, by default):
--italic-text=always

# Uncomment the following line to disable automatic paging:
#--paging=never

# Show line numbers, Git modifications and file header (but no grid)
--style="numbers,changes,header"

# Uncomment the following line if you are using less version >= 551 and want to
# enable mouse scrolling support in `bat` when running inside tmux. This might
# disable text selection, unless you press shift.
#--pager="less --RAW-CONTROL-CHARS --quit-if-one-screen --mouse"

# Syntax mappings: map a certain filename pattern to a language.
#   Example 1: use the C++ syntax for Arduino .ino files
#   Example 2: Use ".gitignore"-style highlighting for ".ignore" files
#--map-syntax "*.ino:C++"
#--map-syntax ".ignore:Git Ignore"
