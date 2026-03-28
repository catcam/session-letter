#!/usr/bin/env bash
# session-letter — SessionStart hook
# Reads the last letter and injects it into the session context
#
# Configuration:
#   Set SESSION_LETTER_DIR env var, or edit the default path below.
#   Path can be absolute or relative to where Claude Code runs (project root).
#
# Example: SESSION_LETTER_DIR="/home/user/myproject/tasks/letters"

LETTERS_DIR="${SESSION_LETTER_DIR:-tasks/letters}"

# Use find for robustness with unusual filenames
LAST_LETTER=$(find "$LETTERS_DIR" -maxdepth 1 -name "*.md" 2>/dev/null \
    | sort -r | head -1)

if [ -n "$LAST_LETTER" ]; then
    echo "=== LETTER FROM LAST SESSION ==="
    cat "$LAST_LETTER"
    echo "================================="
fi
# No letter = first session. Silent is correct.
