#Called in .bashrc-snaps
#!/bin/bash
echo "[yay-update] Taking pre-snapshot..."
# Take pre-snapshot and capture the number
SNAP_NUM=$(sudo snapper create --print-number --description "yay pre-update" --type pre)
echo "[yay-update] Snapshot $SNAP_NUM created."

# Log it to ~/.local/state/yay-update-log.txt
LOGFILE="$HOME/.local/state/yay-update-log.txt"
mkdir -p "$(dirname "$LOGFILE")"

# Prune to the last 9 lines if the file exists and has >10 lines
if [[ -f "$LOGFILE" && $(wc -l < "$LOGFILE") -ge 10 ]]; then
    tail -n 9 "$LOGFILE" > "${LOGFILE}.tmp" && mv "${LOGFILE}.tmp" "$LOGFILE"
fi

# Append current snapshot to the bottom
echo "$(date '+%Y-%m-%d %H:%M')  yay pre-update -> snapshot #$SNAP_NUM" >> "$LOGFILE"

echo "[yay-update] Running yay -Syu..."
yay -Syu

bash "$HOME/dotfiles/terminal/rollback-helper.sh"
