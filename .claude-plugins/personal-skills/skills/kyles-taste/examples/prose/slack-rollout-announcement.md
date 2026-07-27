# Slack — rolling out a beta to the org

Internal register. A launch announcement for Cursor Cloud Agents. This is the richest single
sample of Kyle's Slack voice.

---

1. Go set your `MX_SLUG` as a personal env var in cursor.com/dashboard/cloud-agents. Use your
   maintainx email with the `.` removed for the best experience. (This does not impact your
   local environment.)
2. Head to cursor.com/agents
3. Select the maintainx repo
4. And get started with Cursor Cloud Agents

**Helpful links**

- Cursor's docs - I highly recommend checking out the plugin and MCP settings to get your agent
  the context it needs.
- Our docs with some helpful tips, configuration suggestions, and details.
  - Getting Started with Cursor
  - Getting your repo started with Cursor Cloud Agents
  - Cursor Cloud Agents: Help
- Come to #help-team-eng-ai-builder-tools with any questions or issues!

**What's different from local**

- **NO WORKTREES.** All of the work is in an isolated Cursor VM. Parallelize to your heart's
  content.
- Not all SSM config secrets are available. This is intentional! Let us know what you _need_,
  and we'll work with owners to add it.
- Only your agent has access to the new AWS account it runs in. We're trying this out to see if
  we can push the envelope on agent autonomy. Let us know what you think!

P.S. This required switching the team AWS IAM role to our new devagent AWS account. If you have
a workflow that was broken and think this is the cause, please reach out! We can work to create
parity and advise you with a workaround to use the old role.

P.P.S I have not changed the role for other repos. Yet. That's coming soon ™.

P.P.P.S. We're calling this a beta while we iron out the kinks and the team is short-staffed due
to vacations and leaves.

Edit

FYI on some early feedback

1. Initial runs are slower than advertised. Infrastructure needs to be stood up. I forgot to
   note this since I've been living with stood up infra for a week 😅
2. Many folks are having luck not setting `MX_SLUG`. The env is configured to figure it out for
   you, but this agent-driven. That means non-determinism, and Kyle _hates_ non-determinism.

---

## What to copy

- **Numbered steps get no preamble.** The message opens on step 1. Context comes after, if at all.
- **Every link carries a one-line why.** "I highly recommend checking out the plugin and MCP
  settings" — never a bare link, and the recommendation is ranked when there's more than one.
- **Bold caps for the single thing people will get wrong.** "**NO WORKTREES.**" One per message.
- **The P.S. ladder.** Afterthoughts stack rather than getting folded back into the body. It
  reads like someone talking, and it preserves what the original message actually said.
- **"Yet. That's coming soon ™."** Fragment, then a joke that admits the work isn't finished.
- **Caveats stated plainly.** "short-staffed due to vacations and leaves" — the real reason,
  not "resourcing constraints".
- **The Edit block.** Corrections get appended with a visible label, never quietly patched in.
- **Owning the miss without groveling.** "I forgot to note this since I've been living with
  stood up infra for a week 😅" — one clause of explanation, an emoji, move on.
- **Third-person self-reference for the strong opinion.** "Kyle _hates_ non-determinism."
  Underscore italics on the one word doing the work.
- **Invitations, repeatedly.** "Let us know what you _need_", "Let us know what you think!",
  "Come to #channel with any questions or issues!"
