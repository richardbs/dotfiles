#!/bin/bash

echo -e "🩺 \e[1mRunning dotfiles diagnostic...\e[0m"
echo "ℹ️  This script does not install anything. It only checks your system and dotfiles setup to report what's correct, missing, or misconfigured."

# ----------------------
# Helper Functions
# ----------------------

check_symlink() {
  local link="$1"
  local target="$2"
  echo -n "  $link → "
  if [ -L "$link" ]; then
    if [ "$(readlink -f "$link")" == "$(readlink -f "$target")" ]; then
      echo "✅"
    else
      echo "⚠️  Incorrect target (currently → $(readlink "$link"))"
    fi
  elif [ -e "$link" ]; then
    echo "❌ Exists but is not a symlink"
  else
    echo "❌ Missing"
  fi
}

check_tool() {
  local name="$1"
  echo -n "  $name → "
  if command -v "$name" &>/dev/null; then
    echo "✅"
  else
    echo "❌ Not found (config present, but $name not installed)"
  fi
}

check_script() {
  local path="$1"
  echo -n "  $path → "
  if [ -f "$path" ]; then
    if [ -x "$path" ]; then
      echo "✅"
    else
      echo "⚠️  Exists but not executable"
    fi
  else
    echo "❌ Missing"
  fi
}

check_broken_symlinks() {
  echo -e "\n📂 \e[1mBroken symlinks in dotfiles repo:\e[0m"
  local broken=0
  while IFS= read -r -d '' link; do
    if [ ! -e "$link" ]; then
      echo "  ❌ $link is broken"
      ((broken++))
    fi
  done < <(find "$HOME/dotfiles" -type l -print0)

  if [ "$broken" -eq 0 ]; then
    echo "  → ✅ No broken symlinks found"
  fi
}

# ----------------------
# Checks Begin
# ----------------------

echo -e "\n📂 \e[1mExpected symlinks:\e[0m"
declare -A SYMLINKS=(
  ["$HOME/.bashrc"]="$HOME/dotfiles/bashrc"
  ["$HOME/.config/starship.toml"]="$HOME/dotfiles/starship/starship.toml"
  ["$HOME/.config/kitty/kitty.conf"]="$HOME/dotfiles/kitty/kitty.conf"
)

for link in "${!SYMLINKS[@]}"; do
  check_symlink "$link" "${SYMLINKS[$link]}"
done

echo -e "\n📂 \e[1mSystemd user timers:\e[0m"

echo -e "\n📂 \e[1mOptional CLI tools:\e[0m"
check_tool "starship"
check_tool "kitty"

echo -e "\n📂 \e[1mCustom dotfiles scripts:\e[0m"
check_script "$HOME/dotfiles/install.sh"
check_script "$HOME/dotfiles/terminal/yay-update.sh"
check_script "$HOME/dotfiles/terminal/rollback-helper.sh"
check_script "$HOME/dotfiles/dotfiles_doctor.sh"
check_script "$HOME/dotfiles/plasma-config/install-spectacle-shortcut.sh"

check_broken_symlinks

echo -e "\n✅ \e[1mDotfiles check complete.\e[0m\n"
