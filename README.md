# Richard's Dotfiles

![Arch Linux](https://img.shields.io/badge/OS-Arch_Linux-1793D1?logo=arch-linux&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnu-bash&logoColor=white)
![Terminal](https://img.shields.io/badge/Terminal-Kitty-7F7FFF?logo=windows-terminal&logoColor=white)
![Prompt](https://img.shields.io/badge/Prompt-Starship-2e2e2e?logo=starship&logoColor=white)
![Snapshots](https://img.shields.io/badge/Btrfs%20Snapshots-Snapper%20%2B%20Grub_Btrfs-5e81ac)

A fully Git-managed dotfiles setup for Bash-based systems, built for clarity, reproducibility, and snapshot resilience.

---

## 📦 What's Included

- ✨ **Starship prompt** (Catppuccin Mocha theme)
- 🐱 **Kitty terminal** config with aliases, fonts, and theming
- 🧠 **Modular Bash config** via `.bashrc`, `.bashrc-extras`, and `.bashrc-snaps`
- ⚙️ Quality-of-life CLI tools:
  - `lsd`, `bat`, `fzf`, `highlight`, `neofetch`
  - Git-aware prompt state
- 📸 **Snapshot management** using Snapper + grub-btrfs:
  - Pre-update snapshot support via `yay-update.sh`
  - Snapshot info + rollback helper
  - Timeline cleanup with age + count management
- 🔁 **Dotfile sync** via systemd user timer (`dotfiles-sync.timer`)
- 🩺 **Doctor script** to verify symlinks, tools, scripts, and broken links

---

## 🛠 Installation

    git clone git@github.com:richardbs/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    bash install.sh

This will:

- Create symlinks for:
  - `~/.bashrc` → `~/dotfiles/bashrc`
  - `~/.config/starship.toml` → `~/dotfiles/starship/starship.toml`
  - `~/.config/kitty/kitty.conf` → `~/dotfiles/kitty/kitty.conf`
- Optionally install Snapper config if present (`snapshots/snapper-root.conf`)
- Install a systemd user timer to run `sync_dotfiles.sh` twice daily

---

## 🔄 Keeping Dotfiles in Sync

After making local changes:

    bash ~/dotfiles/sync_dotfiles.sh

This will:

- Commit & push changes if your working directory is clean
- Pull remote changes if behind
- Notify via `notify-send` if triggered by systemd
- Run `dotfiles_doctor.sh` to check for config drift

---

## 📋 Notes on `.bashrc` & Structure

- `~/.bashrc` is fully Git-managed via symlink
- It sources:
  - `~/dotfiles/terminal/.bashrc-snaps` — snapshot helper aliases/functions
  - `~/dotfiles/terminal/.bashrc-extras` — CLI tools, aliases, completions
- All CLI helpers and aliases are scoped to Bash
- Dotfiles are declarative — `.bashrc` is never patched, only replaced

---

## 🧪 Diagnostic

Run this anytime:

    bash ~/dotfiles/dotfiles_doctor.sh

This checks:

- Dotfile symlink correctness
- Script presence + executable bit
- Broken symlinks inside `~/dotfiles`
- Required CLI tools (like `starship`, `kitty`)
- Systemd timer status

---

## 🗃 File Layout

    dotfiles/
    ├── bashrc                   # Primary Bash config (symlinked to ~/.bashrc)
    ├── install.sh              # Main installer for symlinks and systemd setup
    ├── sync_dotfiles.sh        # Git pull/push + error handling
    ├── dotfiles_doctor.sh      # Verifies system consistency
    ├── starship/
    │   └── starship.toml
    ├── kitty/
    │   └── kitty.conf
    ├── terminal/
    │   ├── .bashrc-extras      # Aliases, CLI tools, completions
    │   ├── .bashrc-snaps       # Snapshot CLI helpers
    │   ├── yay-update.sh       # Pre-snapshot yay wrapper
    │   └── rollback-helper.sh  # Lists snapshot info in human-readable way
    └── plasma-config/
        └── install-spectacle-shortcut.sh

---

## ✅ System Assumptions

This dotfiles setup is designed for:

- Arch Linux (or derivatives like EndeavourOS)
- Bash-based systems only
- Kitty terminal + Starship prompt
- Snapper configured with `grub-btrfs`
