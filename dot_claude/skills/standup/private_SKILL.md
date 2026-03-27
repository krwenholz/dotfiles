---
name: standup
description: "Generate a daily standup post for Slack. Use when the user types /standup or asks to generate their standup."
---

# Daily Standup Generator

Generate a Slack-ready standup post by pulling from GitHub PRs and Linear issues.

## Configuration

- **GitHub username**: krwenholz
- **Linear workspace**: faynutrition
- **Linear view for recent issues**: krws-recent-issues-8dfe000ddcb4

## Process

### Step 1: Determine Date Range

- **Normal days**: Yesterday only
- **Mondays**: Friday through Sunday (the whole weekend)

Use today's date to calculate appropriately.

### Step 2: Fetch Data (Try Multiple Methods)

Try these methods in order until one works:

**Method A: MCP Tools (if available)**
- `mcp__github__search_pull_requests` for PRs
- `mcp__linear__list_issues` or similar for Linear

**Method B: CLI Tools (if available)**
```bash
gh pr list --author krwenholz --state closed --json title,url,closedAt
gh pr list --author krwenholz --state open --json title,url
```

**Method C: GitHub Public API**
```
WebFetch: https://api.github.com/search/issues?q=author:krwenholz+type:pr
```
Note: Only returns public repos. Private repos need auth.

**Method D: Ask the User**
If automated methods fail, ask the user to paste recent activity from:
- https://github.com/pulls?q=is%3Apr+author%3Akrwenholz+archived%3Afalse
- Their Linear recent issues view

### Step 3: Check Slack for Uncaptured Work

After fetching GitHub and Linear data, review Slack for anything not already represented:

1. **Check default channels first**, then **ask the user** if they want to add more. Default channels: `#engineering-discussions`, `#engineering-public`, `#engineering-errors`, `#data-pod`, `#octo`. Use `mcp__claude_ai_Slack__slack_search_channels` to find additional channels by name if needed.
2. **Read each channel** using `mcp__claude_ai_Slack__slack_read_channel` with `oldest` and `latest` timestamps matching the date range from Step 1. Use `response_format: "concise"` to keep output manageable.
3. **Scan for standup-worthy items** the user participated in:
   - Discussions about completed work not tied to a PR or Linear issue
   - Decisions made, questions answered, or blockers resolved
   - Ad-hoc reviews, pairing sessions, or help given to others
   - FYIs, announcements, or context shared with the team
4. **Cross-reference** against the GitHub/Linear data already collected. Only surface items that aren't already captured.
5. **Present Slack-sourced items** to the user for confirmation before including them.

### Step 4: Gather Data

**For Yesterday:**
- Closed/merged PRs within date range
- Completed Linear issues (include the `project` field from Linear data)
- Slack-sourced items confirmed in Step 3
- Match PRs to Linear issues by ticket ID in PR title (e.g., `[FAY-1234]`) to inherit the project grouping

**For Today:**
- Open PRs (in review or draft)
- In-progress Linear issues (include the `project` field)
- Slack-sourced upcoming items (if any)
- Ask user what they're planning to work on

**Cycle Commitments & What's Next:**
- Fetch the user's current cycle issues using `mcp__claude_ai_Linear__list_issues` with `assignee: "me"` and the current cycle filter. List any cycle issues not yet started or in a blocked state — these are candidates for "what's next."
- After the standup draft, present a **Cycle check-in** section showing remaining cycle commitments (Todo, In Progress, In Review) with their status, and suggest which issue to pick up next based on priority.
- If it's not clear what the next steps are on an issue (vague title, no description, unclear scope), **ask the user** to clarify before suggesting it.

### Step 5: Generate the Standup

Format with Slack-compatible markdown. **Every item MUST be a markdown link.** No bare text items without a link.

**Formatting rules (follow exactly):**
- Every bullet starts with a markdown link: `[visible text](url)`
- PRs link to GitHub: `[PR title](https://github.com/org/repo/pull/123)`
- Linear issues link to Linear: `[FAY-123: Issue title](https://linear.app/faynutrition/issue/FAY-123)`
- Slack-sourced items with no URL: use a descriptive label without a link, but prefer linking to the Slack message permalink if available
- A dash ` - ` separates the link from the description sentence
- Group items under `## Project Name` subheadings using the **Linear project name** from the issue data. Match PRs to their Linear issue's project when possible (e.g., a PR titled `[FAY-8609] ...` belongs to whatever project FAY-8609 is in).
- Items with **no Linear project** (e.g., CI/CD cleanup PRs, ad-hoc fixes) go ungrouped at the top of the Yesterday/Today section, before any project headings.
- Only create a `## Project Name` heading when 2+ items share that project. A single item from a project can stay ungrouped at the top.
- End with `Happy [Day]!`

**Template (follow this structure rigorously):**
```
# Yesterday
- [PR title](github_pr_url) - Description sentence. (ungrouped, no Linear project)

## [Linear Project Name]
- [PR title](github_pr_url) - Description sentence.
- [FAY-123: Issue title](linear_issue_url) - Description sentence.

## [Another Linear Project Name]
- [PR title](github_pr_url) - Description sentence.

# Today
- [Open PR title](github_pr_url) - What you're doing with it. (ungrouped)

## [Linear Project Name]
- [FAY-456: In-progress issue](linear_issue_url) - What you're focusing on.

Happy [Day]!
```

**Link checklist (verify before presenting draft):**
- [ ] Every PR has a clickable `[title](url)` link to the GitHub PR
- [ ] Every Linear issue has a clickable `[ID: title](url)` link to Linear
- [ ] No bare titles without links
- [ ] All URLs are real, not placeholders

### Step 6: Ask for User Input

After presenting the draft and cycle check-in, ask:
1. "Any FYIs to add or tweaks?"
2. If any cycle issues have unclear next steps, ask about those specifically.

### Step 7: Generate Gemini Image Prompt

Pick ONE random aesthetic from this list:
- Star chart / celestial map
- Retro pixel art dashboard
- Botanical illustration with data vines
- Blueprint / architectural schematic

Generate a short prompt with just the aesthetic and vibe — no summary stats or item counts. Gemini will have the full standup text to work from.

```
Create an infographic in a [AESTHETIC] style, in a fun animated style. Keep it playful and celebratory of the work done. [Optional vibe note, e.g. "Friday vibes, beach PTO incoming."]
```

## Voice & Tone Guidelines

Write like Kyle - casual, direct, and friendly:

- **Use contractions and casual language**: "gonna", "kinda", "I'll probably..."
- **Be honest about uncertainty**: "Some PRs I'm forgetting" is better than forced completeness
- **Group by Linear project**: Use `## Heading` with the actual Linear project name — don't invent section names
- **Keep bullets brief**: One line each, no fluff
- **Use complete sentences**: End bullets with periods for readability
- **Light humor welcome**: Self-deprecating acknowledgments, fun observations
- **Address team as "folks"** when relevant
- **End with day greeting**: "Happy [Day]!" - occasionally add flair when appropriate

**Good examples from Kyle:**
- "Finally got a dev Airtable set up."
- "I'm a just gonna copy Jacob's work."
- "It mostly makes sense, but it's also kinda black magic DBA territory."
- "Unless someone else wants to grab it, I'll try to get to pg_repack next week."

**Avoid:**
- Over-formal language
- Excessive detail in bullets
- Corporate jargon
- Forced enthusiasm

## Output

After user confirms the standup content, present both blocks for easy copying:

1. **Gemini image prompt** in a code block
2. **Standup text** in a code block (repeated here for easy copy-paste after the image prompt)

This order lets the user copy the image prompt first, generate the image, then grab the standup text right below it.

### Step 8: Write to /tmp/my-standup and open in nvim

After the user confirms the final standup text:

1. Write to `/tmp/my-standup` with the Gemini image prompt (no label, just the raw prompt text) at the top, followed by a `---` separator, then the standup text.
2. Open it in a new tmux pane: `tmux split-window -h -t <current_pane> "nvim /tmp/my-standup"`

This gives the user an easy copy-paste surface for both the standup and the image prompt.
