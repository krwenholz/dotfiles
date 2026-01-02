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

### Step 3: Gather Data

**For Yesterday:**
- Closed/merged PRs within date range
- Completed Linear issues

**For Today:**
- Open PRs (in review or draft)
- In-progress Linear issues
- Ask user what they're planning to work on

### Step 4: Generate the Standup

Format with Slack-compatible markdown. Group items by project/area when patterns emerge.

**Template:**
```
# Yesterday
- [PR title](github_url) - Description sentence.
- [ISSUE-ID: Issue title](linear_url) - Description sentence.
## [Project Area] (if multiple items relate)
- [Link](url) - Description.

# Today
- [Open PR title](github_url) - What you're doing with it.
- [ISSUE-ID: In-progress issue](linear_url) - What you're focusing on.

Happy [Day]!
```

Note: Use a dash to separate the link from the description for better readability.

### Step 5: Ask for User Input

After presenting the draft, ask:
1. "Any FYIs to add or tweaks?"

### Step 6: Generate Gemini Image Prompt

Pick ONE random aesthetic from this list:
- Star chart / celestial map
- Retro pixel art dashboard
- Botanical illustration with data vines
- Blueprint / architectural schematic

Generate a prompt like:
```
Create an infographic in a [AESTHETIC] style, in a fun animated style, showing:
[X] PRs merged, [Y] issues completed. Key themes: [extracted from PR/issue titles].
Keep it playful and celebratory of the work done.
```

## Voice & Tone Guidelines

Write like Kyle - casual, direct, and friendly:

- **Use contractions and casual language**: "gonna", "kinda", "I'll probably..."
- **Be honest about uncertainty**: "Some PRs I'm forgetting" is better than forced completeness
- **Group by project**: Use `## Heading` for project areas (e.g., `## Provider Payouts`)
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
