# ~/.bashrc

# Run neofetch on interactive shells
if [[ $- == *i* ]] && command -v neofetch >/dev/null; then
  neofetch
fi

# --- Sources to call ---

# Global definitions
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

# Source snapshot-specific
if [ -f ~/dotfiles/terminal/.bashrc-snaps ]; then
    source ~/dotfiles/terminal/.bashrc-snaps
fi

# Source for terminal aliases and utilities
if [ -f ~/dotfiles/terminal/.bashrc-extras ]; then
    source ~/dotfiles/terminal/.bashrc-extras
fi

# Set EDITOR
export EDITOR=nano

# Set terminal title to current working directory
PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'

# Load Starship Prompt
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
eval "$(starship init bash)"

# Git prompt settings
export GIT_PS1_SHOWDIRTYSTATE=1

echo "Welcome, $USER 👋"
