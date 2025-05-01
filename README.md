# Richard's Dotfiles

![Arch Linux](https://img.shields.io/badge/OS-Arch_Linux-1793D1?logo=arch-linux&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?logo=gnu-bash&logoColor=white)
![Terminal](https://img.shields.io/badge/Terminal-Kitty-7F7FFF?logo=windows-terminal&logoColor=white)
![Prompt](https://img.shields.io/badge/Prompt-Starship-2e2e2e?logo=starship&logoColor=white)
![Snapshots](https://img.shields.io/badge/Btrfs%20Snapshots-Snapper%20%2B%20Grub_Btrfs-5e81ac)

## 📦 Includes
- ✨ Starship prompt (Catppuccin Mocha theme)
- 🐱 Kitty terminal with custom config and theming
- ⚙️ Bashrc enhancements: `lsd`, `bat`, `fzf`, syntax highlighting, completions
- 📸 Snapshot dashboard + auto-clean config using Snapper + grub-btrfs
- 🧠 Modular bash config: `.bashrc-snaps` and `.bashrc-extras`
- 🔄 Install script for symlinks and daily auto-sync
- 🔁 Sync script for pushing dotfiles to GitHub

## 🛠 Installation
```bash
git clone git@github.com:richardbs/dotfiles.git
cd dotfiles
bash install.sh
