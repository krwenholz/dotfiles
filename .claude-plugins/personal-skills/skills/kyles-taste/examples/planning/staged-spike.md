# Proposing a spike, not a build

Kicking off a bigger piece of speculative work — porting shared shell scripts to a Go CLI. Long
and discursive, the opposite register from the terse examples elsewhere in this rubric, but the
same underlying shape.

---

> We have a bunch of shared configuration for Cursor Cloud agents in `@acme/` `@acme-stone/`
> `@acme-directory/` `@acme-auth/` and `@acme-foundry/`… That bash is 1) hard to read, 2) hard to
> test, and 3) brittle (it's bash).
>
> We think porting this to go would be desirable:
> 1. Resolves 1 and 2 and probably 3
> 2. Should be easy to distribute on Cursor Cloud Agents who have ssh access (we think)
>
> …Let's come up with a testing and validation plan. I'm interested in quickly spiking on
> feasibility. If it works, then we should consider what a go CLI/package for this configuration
> may look like.
>
> Some tips: 1. I'd like for you to lean on cheaper models like Sonnet and Opus for subagents… 2.
> You have access to an API key in `~/.cursorkey` 3. Let me know if you have questions! Don't feel
> like you need to work around every issue on your own (although I'm hoping you can mostly tackle
> this on your own).

---

## What to copy

- **States the problem as a numbered list of pain points before proposing anything.** Hard to
  read, hard to test, brittle — three separate, concrete complaints, not "this code is bad."
- **Justifies the fix against those same numbers.** "Resolves 1 and 2 and probably 3" — the
  proposal is checked against the problem statement it just made, in the same breath.
- **A spike gates the real build, it doesn't replace it.** "If it works, then we should consider…"
  — staged commitment. Feasibility gets proven small before the bigger thing gets scoped at all.
- **Autonomy calibrated explicitly, in the same message as the ask.** Which models to delegate to,
  what access already exists, permission to struggle without checking in every time — paired with
  an honest hope that it won't be needed.
