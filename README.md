# session-letter

**Continuity across AI sessions — letters from Claude to its future self.**

[Claude Code](https://claude.ai/code) is Anthropic's CLI agent for software development. It forgets everything between sessions.

---

## The Problem

Compact summaries preserve facts, but lose voice. The next Claude knows *what happened* but not *how it felt* — the tone of the conversation, what the user was worried about, what was almost said.

This is the gap between information and continuity.

## The Solution

At the end of each session, Claude writes a letter to its future self. Not a summary. Not a structured report. A letter — with voice, context, and the things that matter but don't fit in `lessons.md`.

At the start of the next session, Claude reads the last letter. It arrives with context, not just state.

## Why Not CLAUDE.md or lessons.md?

Those are for facts — architecture decisions, known bugs, rules. This is for voice — how the session felt, what the user was worried about, what you'd want to know if you were starting fresh. They complement, not replace.

## How It Works

```
Session A ends → /session-letter → tasks/letters/2026-03-29.md
Session B starts → SessionStart hook reads last letter → injected into context
```

Three components:

1. **`SKILL.md`** — the `/session-letter` skill for Claude Code
2. **`hooks/session-start.sh`** — reads last letter at session start, injects into context
3. **`hooks/pre-compact.sh`** — checks if today's letter is written, reminds if not

---

## Install

### 1. Skill

```bash
mkdir -p ~/.claude/skills/session-letter
cp SKILL.md ~/.claude/skills/session-letter/SKILL.md
```

Claude Code automatically scans `~/.claude/skills/` for available skills.

### 2. Letters directory

```bash
mkdir -p your-project/tasks/letters
```

The hooks default to `tasks/letters` relative to your project root (where Claude Code runs). To use a different path, set the `SESSION_LETTER_DIR` environment variable:

```bash
export SESSION_LETTER_DIR="/absolute/path/to/your/letters"
```

Or edit the default directly in each hook file.

### 3. Hooks

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
    ],
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

If you already have hooks configured, add to the existing arrays — don't replace them.

---

## Usage

At the end of any session:

```
/session-letter
```

Claude writes a letter. Next session reads it automatically.

**First session:** no letter exists yet — that's expected. The hook is silent.

**Letter lifecycle:** letters accumulate in `tasks/letters/`. Only the most recent is read at session start. You can archive or delete old ones freely — they're just markdown files.

---

## What a Letter Looks Like

See [`examples/example-letter.md`](examples/example-letter.md).

The format is intentionally open. No sections, no bullet points. Just a letter. Length: whatever feels right — 200 to 600 words is typical.

---

## On Writing in Your Own Voice

The next Claude doesn't *remember* — it reads a document and performs continuity. That's an honest description of what's happening here.

The question is whether the performance is useful. We've been running this in production for months across a long-running software project, and the answer is yes — but only when the letter is written in voice, not in structure.

Here's the concrete difference. After one session we had this in the letter:

> *"The bug was elegant in its stupidity — `asks[0]` returns the worst ask, not the best. CLOB orderbook is reverse sorted. Gamma API was telling the truth the whole time. One character: `[0]` → `[-1]`."*

The changelog said: *"Fixed orderbook indexing bug."*

Next session, Claude referenced the orderbook sorting behavior unprompted when a similar issue appeared in a different file — made the connection without being asked. That doesn't happen from a changelog. It happens from context.

The letter isn't written *about* Claude. It's written *by* Claude, *to* Claude — first person, with the texture of how something was understood, not just what was done. The result is a next session that arrives oriented to the work rather than reconstructing it.

---

## Philosophy

For a deeper treatment of AI identity across sessions, see [`PHILOSOPHY.md`](PHILOSOPHY.md).

---

## Related Work

Several projects approach the session continuity problem. Here's how session-letter relates to each:

**[Auto-Dream](https://github.com/Piebald-AI/claude-code-system-prompts)** (Claude Code) — a reflective subagent that consolidates memory between sessions, literally described as "performing a dream." Structured phases: orient, gather, consolidate, prune. Excellent for factual memory consolidation. Doesn't write in first-person voice or preserve relational texture.

**[Claude Diary](https://rlancemartin.github.io/2025/12/01/claude_diary/)** — slash commands (`/diary`, `/reflect`) to capture accomplishments and propose CLAUDE.md updates. Learning-focused, instruction-focused. Closer to lessons.md than to a letter.

**[Story Keeper](https://news.ycombinator.com/item?id=45685363)** — uses narrative continuity (characters, arc, themes) instead of structured memory. Closest in philosophy to session-letter. Doesn't emphasize the AI's own voice writing to itself; focuses more on the user's story.

**[SOUL.md](https://soul.md/)** — proposes persistent identity documents defining values and boundaries. Prescriptive (written once, read many times) rather than generative (written each session).

**Structured memory tools** (mem0, Engram, etc.) — database-backed persistent memory. Solve a different problem: factual recall. Lose the voice entirely.

The actual differentiator is narrow and specific: *first-person epistolary format, written at session end, read at session start.* Story Keeper uses narrative, Auto-Dream performs reflection — but neither produces a letter written by one instance of Claude to the next. That format turns out to matter.

---

## Multi-project setup

The skill is global (`~/.claude/skills/`). The letters directory is per-project (`tasks/letters/` or your `SESSION_LETTER_DIR`). Each project maintains its own letter history independently.

---

## Contributing

PRs welcome. Especially:
- Ports to other AI coding assistants (Gemini CLI, Cursor, Copilot)
- Alternative letter formats
- Integration with other context monitors

MIT License.
