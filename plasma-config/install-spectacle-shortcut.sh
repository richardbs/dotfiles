#!/bin/bash

# Check for Spectacle
if ! command -v spectacle &> /dev/null; then
    echo "Spectacle is not installed. Skipping shortcut import."
    exit 0
fi

# KDE hotkeys directory
HOTKEYS_DIR="$HOME/.config/khotkeys"

# Create dir if missing
mkdir -p "$HOTKEYS_DIR"

# Copy .khotkeys file
cp spectacle_f16.khotkeys "$HOTKEYS_DIR/"

echo "Shortcut imported. You may need to restart KDE or log out/log in to apply it."
