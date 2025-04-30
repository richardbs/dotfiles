#!/bin/bash
cd ~/dotfiles || exit

git pull --rebase
PULL_EXIT_CODE=$?

if [ $PULL_EXIT_CODE -ne 0 ]; then
    notify-send "❌ Dotfiles Sync Failed" "Git pull failed! Check ~/dotfiles/sync.log"
    exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "Local auto-sync update"
    git push
    PUSH_EXIT_CODE=$?

    if [ $PUSH_EXIT_CODE -ne 0 ]; then
        notify-send "❌ Dotfiles Sync Failed" "Git push failed! Check ~/dotfiles/sync.log"
        exit 1
    fi

    notify-send "✅ Dotfiles Sync" "Local changes committed and pushed successfully!"
else
    echo "✅ No local changes."
fi
