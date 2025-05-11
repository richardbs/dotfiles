#!/bin/bash
echo "🔗 Creating symlinks for your dotfiles..."

# ─── Symlink configs ─────────────────────────────────────────────────────
mkdir -p ~/.config
ln -sf ~/dotfiles/starship/starship.toml ~/.config/starship.toml
mkdir -p ~/.config/kitty
ln -sf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/nanorc ~/.nanorc

echo "✅ Symlinks created."

# ─── Run dot doc ─────────────────────────────────────────────────────────
echo -e "\nVerifying installation with dotfiles_doctor..."
bash ~/dotfiles/dotfiles_doctor.sh

# ─── Final message ───────────────────────────────────────────────────────
echo "Dotfiles installation complete!"
echo "Reminder: Restart terminal or 'source ~/.bashrc' to apply changes."
