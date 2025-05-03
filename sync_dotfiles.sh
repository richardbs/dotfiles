#!/bin/bash

cd "$HOME/dotfiles" || exit

# Check if run by systemd
IS_SYSTEMD_RUN=false
[ -n "$INVOCATION_ID" ] && IS_SYSTEMD_RUN=true

log() {
  $IS_SYSTEMD_RUN || echo "$1"
}

notify() {
  $IS_SYSTEMD_RUN && notify-send "$1" "$2"
}

log "🔄 Starting dotfiles sync..."

# Check for dirty working directory
if ! git diff --quiet || ! git diff --cached --quiet; then
  log "❌ Working directory is dirty — commit or stash your changes before syncing."
  log "   To fix:"
  log "     git add ."
  log "     git commit -m \"Your message here\""
  notify-send -t 0 "❌ Dotfiles Sync Failed" "Working directory dirty. Run:\ngit add .\ngit commit -m 'message'"
  exit 1
fi

log "📥 Pulling latest changes from remote..."
git pull --rebase
PULL_EXIT_CODE=$?

if [ $PULL_EXIT_CODE -ne 0 ]; then
  notify "❌ Dotfiles Sync Failed" "Git pull failed! Check ~/dotfiles manually."
  log "❌ Git pull failed!"
  exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
  log "📝 Local changes detected — committing and pushing..."

  git add .
  git commit -m "Local auto-sync update"
  git push
  PUSH_EXIT_CODE=$?

  if [ $PUSH_EXIT_CODE -ne 0 ]; then
    notify "❌ Dotfiles Sync Failed" "Git push failed! Check ~/dotfiles manually."
    log "❌ Git push failed!"
    exit 1
  fi

  notify "✅ Dotfiles Sync" "Local changes committed and pushed!"
  log "✅ Local changes synced with remote."
else
  log "✅ No local changes — already up to date."
fi
