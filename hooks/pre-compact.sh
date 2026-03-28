#!/usr/bin/env bash
# session-letter — PreCompact hook
# Reminds Claude to write a letter before auto-compact

LETTERS_DIR="${SESSION_LETTER_DIR:-tasks/letters}"
LAST_LETTER=$(ls -t "$LETTERS_DIR"/*.md 2>/dev/null | head -1)

cat << EOF
IF YOU HAVEN'T WRITTEN A LETTER THIS SESSION: run /session-letter before compact finishes.
LAST LETTER: ${LAST_LETTER:-"(none yet)"}
EOF
