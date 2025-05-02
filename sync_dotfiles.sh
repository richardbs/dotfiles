#!/bin/bash

cd "$HOME/dotfiles" || exit

# Check if we're running under systemd
IS_SYSTEMD_RUN=false
[ -n "$INVOCATION_ID" ] && IS_SYSTEMD_RUN=true

log() {
  $IS_SYSTEMD_RUN || echo "$1"
}

log "🔄 Starting dotfiles sync..."

# Pull from remote
log "📥 Pulling latest changes from remote..."
git pull --rebase
PULL_EXIT_CODE=$?

if [ $PULL_EXIT_CODE -ne 0 ]; then
  $IS_SYSTEMD_RUN && notify-send "❌ Dotfiles Sync Failed" "Git pull failed! Check ~/dotfiles manually."
  log "❌ Git pull failed!"
  exit 1
fi

# If there are local changes, commit & push
if [ -n "$(git status --porcelain)" ]; then
  log "📝 Local changes detected — committing and pushing..."

  git add .
  git commit -m "Local auto-sync update"
  git push
  PUSH_EXIT_CODE=$?

  if [ $PUSH_EXIT_CODE -ne 0 ]; then
    $IS_SYSTEMD_RUN && notify-send "❌ Dotfiles Sync Failed" "Git push failed! Check ~/dotfiles manually."
    log "❌ Git push failed!"
    exit 1
  fi

  $IS_SYSTEMD_RUN && notify-send "✅ Dotfiles Sync" "Local changes committed and pushed!"
  log "✅ Local changes synced with remote."
else
  log "✅ No local changes — already up to date."
fi
