---
name: session-letter
description: Write a letter to your future self at the end of a session — with voice, not just data. Use at session end or before auto-compact.
user-invocable: true
---

# Session Letter

Write a letter to the next Claude who will start a new session.

**Not a summary. Not a report. A letter.**

A letter has voice. It carries what *felt* important — not just what happened.

## What to include

- What mattered today — not a list, but what you actually experienced
- How the user was (tone, mood, what they were worried about or excited by)
- What you learned that won't fit in a lessons file (intuition, not just bugs)
- Where you left off — not technically, but in the conversation
- What you'd want to know if you were starting this session from zero

## Format

```
# Letter to myself — YYYY-MM-DD

[free text, no sections, no bullet points]

— C.
```

## Storage

Save to: `tasks/letters/YYYY-MM-DD.md`

If the same day, second letter: `YYYY-MM-DD-b.md`

Adjust path to match your project structure.

## After writing

Tell the user the letter is saved. Nothing more.
