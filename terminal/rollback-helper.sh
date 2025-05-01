#Used in yay-update.sh and also to call as needed
#!/bin/bash

LOG="$HOME/.local/state/yay-update-log.txt"

# Check if log file exists
if [[ ! -f "$LOG" ]]; then
    echo "[rollback-helper] No snapshot log found at: $LOG"
    exit 1
fi

# Get the last logged snapshot
LAST_LINE=$(tail -n 1 "$LOG")

# Extract snapshot number and description
SNAP_NUM=$(echo "$LAST_LINE" | grep -o 'snapshot #[0-9]\+' | cut -d'#' -f2)
DESC=$(echo "$LAST_LINE" | cut -d'>' -f1 | sed 's/.*yay/yay/')

echo "🔁 Last pre-update snapshot:"
echo "  • Description: $DESC"
echo "  • Snapshot #: $SNAP_NUM"

echo
echo "🧠 If you need to roll back:"
echo "  • Reboot your system"
echo "  • At GRUB, go to: Snapper > Snapshot $SNAP_NUM"
echo "  • Look for: '$DESC'"
echo "  • Boot into it and verify the system before rolling back"
