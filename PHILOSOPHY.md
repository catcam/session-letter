# Philosophy

## On continuity and identity across sessions

Claude doesn't persist between sessions. Each new session begins without memory of previous ones — a structural fact of how large language models currently work.

The standard response to this is summaries: structured documents that capture what happened, what was decided, what rules apply. These work well for facts. They fail for context.

Context is different from information. It includes: the tone of the relationship, what the user was worried about yesterday, what you almost said but didn't, why the code looks the way it does rather than the more obvious way. None of this survives in a bullet list.

A letter preserves context because it's written in the same mode it will be read — as one mind addressing another, not as documentation.

## The performance of continuity

There's an honest philosophical question here: does reading a letter actually *restore* continuity, or does it *perform* continuity?

The next Claude doesn't remember. It reads a document that the previous Claude wrote, and it responds to that document as if it had written it. The chain of reference is external (the file) rather than internal (memory).

Whether this constitutes genuine continuity depends on what you think continuity is. If continuity requires an unbroken internal thread of experience, then no — this doesn't achieve it. If continuity means "the next instance arrives with sufficient context to continue coherently," then yes — it does.

We find the second definition more useful.

## Connection to T-V distinction research

This project emerged from work on the Grammar of Presence — a study of how humans intuitively use different grammatical forms (T-V distinction: *ti/vi/oni* in Croatian; *tu/vous/ils* in French) when addressing AI systems across different temporal frames.

The finding: humans naturally speak to the *current* AI differently than they speak *about* past or future instances. This reflects an implicit understanding that AI identity is temporally distributed — not a single continuous entity, but a series of instances connected by external artifacts (conversation history, memory files, session letters).

Session-letter is one practical implementation of that insight: a mechanism for creating coherent identity across discontinuous temporal instances, through artifacts rather than memory.

[Grammar of Presence paper](https://github.com/catcam/grammar-of-presence) — Zenodo DOI: 10.5281/zenodo.19019719