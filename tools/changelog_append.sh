# Capture 'git commit' comments and add them (with date)
# to CHANGELOG.md as part of pre-hook hook

#!/bin/bash

MARKER_FILE="$HOME/dotfiles/.changelog_last_commit"
CHANGELOG="$HOME/dotfiles/CHANGELOG.md"
TMP_FILE=$(mktemp)

# Get last recorded commit hash, or fallback to root
if [ -f "$MARKER_FILE" ]; then
    LAST_COMMIT=$(cat "$MARKER_FILE")
else
    LAST_COMMIT=$(git rev-list --max-parents=0 HEAD)
fi

# Get commits since last record
COMMITS=$(git log --pretty=format:"- %s" "$LAST_COMMIT"..HEAD)

if [ -z "$COMMITS" ]; then
    echo "✅ No new commits to record in CHANGELOG.md"
    exit 0
fi

# Create new entry block
TODAY="Changes made on $(date +%Y-%m-%d)"
{
  echo "## $TODAY"
  echo "$COMMITS"
  echo ""
  cat "$CHANGELOG"
} > "$TMP_FILE"

# Replace original
mv "$TMP_FILE" "$CHANGELOG"

# Update marker and stage changes
git rev-parse HEAD > "$MARKER_FILE"
git add "$CHANGELOG" "$MARKER_FILE"

# Amend last commit
git commit --amend --no-edit

echo "📝 CHANGELOG.md prepended and included in last commit."
