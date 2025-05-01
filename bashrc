# ~/.bashrc

# Run neofetch on interactive shells
if [[ $- == *i* ]] && command -v neofetch >/dev/null; then
  neofetch
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Aliases
alias ll='ls -lah --color=auto'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# Set EDITOR
export EDITOR=nano

# Set terminal title to current working directory
PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'

# Load Starship Prompt
eval "$(starship init bash)"

# Git prompt settings
export GIT_PS1_SHOWDIRTYSTATE=1

# Load snapshot and terminal aliases from dotfiles
if [ -f ~/dotfiles/terminal/.bashrc-snaps ]; then
    source ~/dotfiles/terminal/.bashrc-snaps
fi

if [ -f ~/dotfiles/terminal/.bashrc-extras ]; then
    source ~/dotfiles/terminal/.bashrc-extras
fi

# Use bat instead of cat
if command -v batcat &>/dev/null; then
  alias cat='batcat --style=plain'
elif command -v bat &>/dev/null; then
  alias cat='bat --style=plain'
fi

# Use lsd instead of ls
if command -v lsd &>/dev/null; then
  alias ls='lsd'
  alias ll='lsd -l'
  alias la='lsd -la'
fi

# Fuzzy finder (fzf) keybindings and tab completion
if [[ -n "$DISPLAY" ]] && command -v fzf &>/dev/null; then
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

# Enable bash completion if available
if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

# Syntax highlighting (bash-preexec + highlight if installed)
if command -v highlight &>/dev/null; then
  export LESSOPEN="| highlight %s --out-format=xterm256 --force"
  export LESS=' -R '
fi

echo "Welcome, $USER 👋"
