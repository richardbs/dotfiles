
# ~/.bashrc

## Run neofetch on interactive shells
#if [[ $- == *i* ]] && command -v neofetch >/dev/null; then
#  neofetch
#fi

# --- Sources ---

# Global definitions
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

# Source snapshot-specific
if [ -f ~/dotfiles/terminal/bashrc-snaps ]; then
    source ~/dotfiles/terminal/bashrc-snaps
fi

# Source for terminal aliases and utilities
if [ -f ~/dotfiles/terminal/bashrc-extras ]; then
    source ~/dotfiles/terminal/bashrc-extras
fi

# Set EDITOR
export EDITOR=nano

# Set TERM - Nano on Proxmox VM's won't work without this line
export TERM=xterm

# Load Starship Prompt
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
eval "$(starship init bash)"

# Git prompt settings
export GIT_PS1_SHOWDIRTYSTATE=1
