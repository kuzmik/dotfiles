# ~/.config/zsh/rc.d/20-options.zsh
#
# Shell and history options.

setopt AUTO_PUSHD               # Push the old directory onto the stack on cd.
setopt CDABLE_VARS              # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB            # Use extended globbing syntax.
setopt EXTENDED_HISTORY         # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS        # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE        # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS        # Do not write a duplicate event to the history file.
setopt PUSHD_IGNORE_DUPS        # Do not store duplicates in the stack.
setopt PUSHD_SILENT             # Do not print the directory stack after pushd or popd.
setopt SHARE_HISTORY            # Share history between all sessions.
unsetopt CORRECT                # Spelling correction
unsetopt FLOW_CONTROL           # Ctrl+S and Ctrl+Q usually disable/enable tty input. This disables those inputs
