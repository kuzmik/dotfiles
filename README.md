# Dotfiles

REDOING IT ALL.

## One liner setup

```bash
# use main
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply kuzmik

# use a specific branch
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply --branch kuzmik/refactor kuzmik
```

-----

## Notes

- If Switch.app configuration changes, run this to update chezmoi:
  - `defaults export com.sanyamgarg.switch - > ~/.local/share/chezmoi/.chezmoitemplates/switch.plist`

-----

## WTF

This shit aint related.

### Fix the locale on debian

```bash
sudo sed -i "s/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen && \ 
    sudo locale-gen en_US.UTF-8 && \
    sudo update-locale LANG=en_US.UTF-8
```
