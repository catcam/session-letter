#!/usr/bin/env bash
# session-letter — PreCompact hook
# Reminds Claude to write a letter before auto-compact
# Checks if a letter was written TODAY specifically

LETTERS_DIR="${SESSION_LETTER_DIR:-tasks/letters}"
TODAY=$(date +%Y-%m-%d)

# Check if a letter exists for today
TODAY_LETTER=$(ls "$LETTERS_DIR/${TODAY}"*.md 2>/dev/null | head -1)
LAST_LETTER=$(ls -t "$LETTERS_DIR"/*.md 2>/dev/null | head -1)

if [ -n "$TODAY_LETTER" ]; then
    cat << EOF
SESSION LETTER: already written today (${TODAY_LETTER}).
EOF
else
    cat << EOF
SESSION LETTER: not written yet today — run /session-letter before compact finishes.
LAST LETTER: ${LAST_LETTER:-"(none yet)"}
EOF
fi
