#!/bin/bash
echo "🩺 Running dotfiles diagnostic..."

# Expected symlinks and their targets
declare -A SYMLINKS=(
  ["$HOME/.bashrc"]="$HOME/dotfiles/bashrc"
  ["$HOME/.config/starship.toml"]="$HOME/dotfiles/starship/starship.toml"
  ["$HOME/.config/kitty/kitty.conf"]="$HOME/dotfiles/kitty/kitty.conf"
)

# Check symlinks
for link in "${!SYMLINKS[@]}"; do
  target="${SYMLINKS[$link]}"
  echo -n "🔍 Checking $link → $target: "
  if [ -L "$link" ]; then
    if [ "$(readlink -f "$link")" == "$(readlink -f "$target")" ]; then
      echo "✅ OK"
    else
      echo "⚠️  Incorrect target (currently → $(readlink "$link"))"
    fi
  elif [ -e "$link" ]; then
    echo "❌ Exists but is not a symlink"
  else
    echo "❌ Missing"
  fi
done

# Check for systemd timer
echo -n "🕒 Checking systemd sync timer: "
if systemctl --user is-enabled dotfiles-sync.timer &>/dev/null; then
  echo "✅ Enabled"
else
  echo "❌ Not enabled"
fi

echo -e "\n🧪 Dotfiles check complete.\n"
