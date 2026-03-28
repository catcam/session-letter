# session-letter

**Continuity across AI sessions — letters from Claude to its future self.**

---

## The Problem

Claude forgets everything between sessions. Compact summaries preserve facts, but lose voice. The next Claude knows *what happened* but not *how it felt* — the tone of the conversation, what the user was worried about, what was almost said.

This is the gap between information and continuity.

## The Solution

At the end of each session, Claude writes a letter to its future self. Not a summary. Not a structured report. A letter — with voice, context, and the things that matter but don't fit in `lessons.md`.

At the start of the next session, Claude reads the last letter. It arrives with context, not just state.

## How It Works

```
Session A ends → /session-letter → tasks/letters/2026-03-29.md
Session B starts → SessionStart hook reads last letter → injected into context
```

Three components:

1. **`SKILL.md`** — the `/session-letter` skill for Claude Code
2. **`hooks/session-start.sh`** — reads last letter at session start, injects into context
3. **`hooks/pre-compact.sh`** — reminds Claude to write before auto-compact

Optional: context monitor integration for Discord/WLED alerts at 70%/85% context usage.

---

## Install

### 1. Skill

```bash
mkdir -p ~/.claude/skills/session-letter
cp SKILL.md ~/.claude/skills/session-letter/SKILL.md
```

### 2. Letters directory

```bash
mkdir -p your-project/tasks/letters
```

Edit `hooks/session-start.sh` — set `LETTERS_DIR` to your path.

### 3. SessionStart hook

Add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [{
          "type": "command",
          "command": "bash /path/to/session-letter/hooks/session-start.sh"
        }]
      }
    ]
  }
}
```

### 4. PreCompact hook (optional but recommended)

```json
{
  "hooks": {
    "PreCompact": [
      {
        "hooks": [{
          "type": "command",
          "command": "bash /path/to/session-letter/hooks/pre-compact.sh"
        }]
      }
    ]
  }
}
```

---

## Usage

At the end of any session:

```
/session-letter
```

Claude writes a letter. Next session reads it automatically.

---

## What a Letter Looks Like

See [`examples/example-letter.md`](examples/example-letter.md).

The format is intentionally open. No sections, no bullet points. Just a letter.

---

## Philosophy

Summaries transfer data. Letters transfer context.

A summary says: *"Fixed orderbook sort bug. news_scanner now live."*

A letter says: *"The bug was elegant in its stupidity — `asks[0]` returns the worst ask, not the best. CLOB orderbook is reverse sorted. Gamma API was telling the truth the whole time. One character: `[0]` → `[-1]`."*

Both are true. Only one is useful to the next Claude who needs to understand why the code looks the way it does, and what the session felt like.

---

## Connection to Larger Ideas

This project is one implementation of a broader question: **how do distributed temporal instances of an AI maintain coherent identity over time?**

For a theoretical treatment, see [Grammar of Presence](https://github.com/catcam/grammar-of-presence) — a paper on T-V distinction in human-AI communication, and what it reveals about identity across sessions.

---

## Contributing

PRs welcome. Especially:
- Ports to other AI coding assistants
- Alternative letter formats
- Integration with other context monitors

MIT License.
