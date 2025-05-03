#!/bin/bash
echo "🔗 Creating symlinks for your dotfiles..."

# ─── Symlink configs ─────────────────────────────────────────────────────
mkdir -p ~/.config
ln -sf ~/dotfiles/starship/starship.toml ~/.config/starship.toml
mkdir -p ~/.config/kitty
ln -sf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/dotfiles/bashrc ~/.bashrc

echo "✅ Symlinks created."

# ─── Install Snapper config if present ────────────────────────────────────
if [ -f ./snapshots/snapper-root.conf ]; then
    echo "📸 Copying Snapper config to /etc..."
    sudo cp ./snapshots/snapper-root.conf /etc/snapper/configs/root
fi

# ─── Set up systemd user timer for dotfile auto-sync ─────────────────────
echo "🕒 Installing systemd timer for dotfile auto-sync (twice daily)..."
mkdir -p ~/.config/systemd/user

cat <<EOF > ~/.config/systemd/user/dotfiles-sync.service
[Unit]
Description=Auto-sync dotfiles to GitHub

[Service]
Type=oneshot
ExecStart=%h/dotfiles/sync_dotfiles.sh
EOF

cat <<EOF > ~/.config/systemd/user/dotfiles-sync.timer
[Unit]
Description=Run dotfiles auto-sync twice daily

[Timer]
OnCalendar=*-*-* 00,12:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user enable --now dotfiles-sync.timer

echo "✅ Systemd timer installed and running."
echo -e "\n🧪 Verifying installation with dotfiles_doctor..."
bash ~/dotfiles/dotfiles_doctor.sh

# ─── Final message ───────────────────────────────────────────────────────
echo "✨ Dotfiles installation complete!"
echo "📅 Github sync runs at 00:00 and 12:00 daily via systemd."
echo "💡 Run 'systemctl --user list-timers' to verify."
echo "➡️  Reminder: Restart terminal or 'source ~/.bashrc' to apply changes."
