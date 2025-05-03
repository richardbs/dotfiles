# Changelog

All notable changes to this dotfiles setup are tracked here.

---

## [2025-05-03]

### Added
- `dotfiles_doctor.sh`: checks symlinks, required tools, systemd timers, and broken links
- `dotfiles-sync.timer`: systemd user timer to auto-push changes to GitHub twice daily
- `rollback-helper.sh`: lists Btrfs snapshots with age and creation timestamp
- Modular Bash config via `.bashrc-extras` (CLI aliases, completions) and `.bashrc-snaps` (snapshot helpers)
- `yay-update.sh`: wrapper script for `yay -Syu` that takes a pre-update Snapper snapshot
- Terminal aliases for `lsd`, `bat`, `fzf`, and other common tools
- Starship prompt config using Catppuccin Mocha theme
- Kitty terminal config with symlinked custom `kitty.conf`
- Install script (`install.sh`) to create symlinks and set up systemd timer

### Changed
- `.bashrc` is now fully Git-managed via symlink (`~/.bashrc` → `~/dotfiles/bashrc`)
- All sourcing of extras and snapshot logic now lives inside the Git-tracked `.bashrc`
- Shell detection logic removed from `install.sh` (Bash-only systems assumed)
- Dotfile syncing now includes notify-send support if triggered by systemd

### Removed
- Legacy `.bash_aliases` logic and conditional patching of `.bashrc`
- Zsh/Fish support scaffolding in favor of a focused Bash-only config
