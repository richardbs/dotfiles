#!/bin/bash
echo "🔗 Creating symlinks for your dotfiles..."

# Symlink configs
mkdir -p ~/.config
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
mkdir -p ~/.config/kitty
ln -sf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/dotfiles/bashrc ~/.bashrc

echo "✅ Symlinks created."

# Setup cronjob for daily sync
CRON_EXISTS=$(crontab -l 2>/dev/null | grep -F "sync_dotfiles.sh" || true)
if [ -z "$CRON_EXISTS" ]; then
    (crontab -l 2>/dev/null; echo "@daily bash ~/dotfiles/sync_dotfiles.sh >> ~/dotfiles/sync.log 2>&1") | crontab -
    echo "🛠️  Daily cronjob for syncing dotfiles installed!"
else
    echo "🛠️  Cronjob for syncing already exists. Skipping."
fi

echo "✨ Installation complete!"
echo "➡️  Reminder: Restart terminal or 'source ~/.bashrc' to apply changes."
