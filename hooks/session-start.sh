#!/usr/bin/env bash
# session-letter — SessionStart hook
# Reads the last letter and injects it into the session context

# Set this to your letters directory
LETTERS_DIR="${SESSION_LETTER_DIR:-tasks/letters}"

LAST_LETTER=$(ls -t "$LETTERS_DIR"/*.md 2>/dev/null | head -1)

if [ -n "$LAST_LETTER" ]; then
    echo "=== LETTER FROM LAST SESSION ==="
    cat "$LAST_LETTER"
    echo "================================="
fi
