# Dotfiles

My dotfiles, version... oh hell, I don't even know... 4 or 5, I'd guess.

This repo supports macOS (darwin) and Linux (Debian, with Arch support coming as soon as I can be bothered to create a VM).

Much of this is highly opinionated and tailored to my personal preferences, but feel free to crib whatever you want. I would NOT just blindly use this repo without first looking at:
  - the scripts in `.chezmoiscripts`
  - `.chezmoiremove`, which deletes certain things out of `$HOME`

## One-liner setup

```bash
# uses main branch
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply kuzmik
```

That will prompt you for a few things (full name, email, computer name, work mode), and then lay down files as needed per your OS and work preferences.

What it needs before it'll work:

- A 1Password account. The age key that decrypts the encrypted files gets pulled from `op://personal/chezmoi age key/private key` in the prepare script; without this, a lot of things will fail
- `sudo` access; macOS uses it for the TouchID / PAM tweak, Debian uses it for apt

## Layout

| Path | What |
| --- | --- |
| `.chezmoidata/packages.yml` | Debian package list; macOS lives in the Brewfile instead |
| `.chezmoiscripts/darwin/` | Homebrew bootstrap, macOS defaults, TouchID sudo, Brewfile install |
| `.chezmoiscripts/linux/` | Distro prep (1Password repo, extrepo + mise), apt install |
| `.chezmoitemplates/` | Shared partials — `osid` |
| `misc/` | Helper scripts and stashed configs (irssi, Raycast export), deliberately not laid down |
| `~/.config/zsh/rc.d/` | Modular zsh config, sourced in numeric order |

### `.osid`

Nearly everything branches on `.osid`, which determines the OS and release ID to use for package management and other platform-specific logic. See `.chezmoitemplates/osid`.

OS/distros that `.osid` supports:
- `darwin` for macOS
- `linux-debian` for Debian (obviously)
- `linux-arch` for Arch Linux (also obviously)

## Packages

### macOS

Driven by the Brewfile at `~/.config/homebrew/Brewfile`, installed via `brew bundle install`. The Brewfile is the source of truth — it's already a declarative manifest and it handles taps, `mas` IDs and cask options that a YAML schema would just have to reinvent, so macOS packages deliberately do **not** live in `packages.yml`.

The install script re-fires whenever the Brewfile changes, via a hash comment at the top. Note that `brew bundle` only ever adds; run `brew bundle cleanup --file=~/.config/homebrew/Brewfile` by hand to prune anything no longer listed.

### Debian 

Edit `packages.debian` in `.chezmoidata/packages.yml`, run `chezmoi apply`. The install script templates the whole list into one `apt install`, so adding a package changes the rendered script and the `run_onchange_` re-fires on its own.

Two things skip apt and install directly to `~/.local/bin` instead:

- Sheldon — no deb package exists
- Atuin — the deb is ancient, so it uses the upstream installer with `ATUIN_INSTALL_DIR`

### Arch

TBD I GUESS

## Work mode

`workMode` gets prompted once at init and gates a decent amount of code in both directions.

Only laid down **in** work mode: 
- gcloud and Kubernetes configs
- work-only brews and Mac App Store apps
- a couple of Raycast scripts
- the custom npm/npq zsh config.

Only laid down **outside** work mode: 
- the `op` config
- my personal SSH config
- the casks that Jamf already manages on the work laptop (1Password).

See `.chezmoiignore` and the Brewfile for what flips.
