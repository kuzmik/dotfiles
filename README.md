# Dotfiles

Just my dotfiles, as well as some sublime3 packages that vanished into the ether (anything Boxy related, apparently) and my iTerm2 config.

## Quickstart

This one liner downloads the `chezmoi` binary and applies the dotfiles from `$GITHUB_USERNAME/dotfiles` repo

```bash
GITHUB_USERNAME=kuzmik sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

## Setup

This repo now uses [chezmoi](https://github.com/twpayne/chezmoi) to manage the dotfiles, rather than toml bombadil.

## Install the `brew` items

Just run `brew bundle` and it will install all of the base utilities I need.

### Work/home differences

NB: I use some templating in here that detects if I am on my work laptop via hostname `arcadia`. If I ever get a new work laptop, this will need to be addressed.
