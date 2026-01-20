---
name: workout
description: "Weekly workout review and planning. Parses journal entries for workout logs, summarizes recent activity, and helps plan the next week. Use when the user types /workout or asks about their workout history/planning."
---

# Weekly Workout Review & Planner

Parse journal entries for workout data, review recent activity patterns, and help plan the upcoming week's training.

## Configuration

- **Journal location**: `~/journal/` (adjust if different)
- **Journal file pattern**: `*.md` files, typically named by date (e.g., `2025-01-20.md` or `january-2025.md`)
- **Workout section marker**: `# Workout` (H1 header)
- **Review period**: Last 7 days by default for weekly planning

## Process

### Step 1: Locate Journal Files

Try these methods in order:

**Method A: Common locations**
```bash
# Check common journal paths
ls ~/journal/*.md 2>/dev/null | head -20
ls ~/notes/*.md 2>/dev/null | head -20
ls ~/Documents/journal/*.md 2>/dev/null | head -20
```

**Method B: Ask the user**
If no journals found, ask: "Where do you keep your journal files? (e.g., ~/journal/)"

### Step 2: Parse Workout Entries

For each journal file in the review period:

1. Search for lines starting with `# Workout` (case-insensitive)
2. Extract all content until the next H1 header (`# `) or end of file
3. Note the date (from filename or file metadata)

**Parsing notes:**
- Workout descriptions may be unstructured prose
- Look for patterns like: exercises, rep counts (e.g., "3x10", "10 reps"), weights, distances, durations
- Note any mentioned body parts, exercise types, or workout styles (strength, cardio, mobility, etc.)

### Step 3: Summarize Recent Workouts

Present a summary with:

**Workout Log (Last 7 Days)**
```
## [Date]
[Parsed workout content - cleaned up but preserving detail]

## [Date]
[...]
```

**Quick Stats:**
- Total workout days: X/7
- Types of training observed: [strength, cardio, etc.]
- Body parts/focus areas mentioned: [legs, upper body, etc.]
- Any patterns or gaps noticed

### Step 4: Analyze Patterns & Gaps

Look for:
- **Consistency**: How many days had workouts?
- **Balance**: Are certain muscle groups neglected?
- **Progression**: Any notes about weights/reps increasing?
- **Recovery**: Rest days between similar workouts?
- **Variety**: Mix of training types?

Be honest about what's unclear from the data. Unstructured notes may not have enough detail for deep analysis.

### Step 5: Plan Next Week

Based on the review, suggest a rough plan:

**Considerations:**
- If user worked legs Monday, maybe not again until Thursday
- If no cardio last week, suggest adding some
- If high intensity all week, suggest a deload or active recovery
- Match the user's apparent preferences and schedule

**Output format:**
```
## Suggested Week Ahead

**Monday**: [suggestion based on patterns]
**Tuesday**: [...]
...

**Notes**: [any observations about recovery, goals to consider, etc.]
```

Ask the user:
1. "Does this align with your goals this week?"
2. "Any scheduled rest days or constraints I should know about?"

### Step 6: Offer Deeper Analysis (Optional)

If the user wants more:
- Compare to previous weeks (if more journal data available)
- Track specific exercises over time
- Note personal records or milestones

---

## Future Integrations

### TODO: Strava Integration

Strava requires OAuth authentication. Options to explore:

**Option A: Manual export**
- User can export activities from Strava settings
- Parse the exported CSV/GPX files

**Option B: API with user's own credentials**
- User creates a Strava API application at https://developers.strava.com/
- Stores their access token securely
- Script fetches recent activities

**Useful endpoints (once authenticated):**
- `GET /athlete/activities` - list activities
- `GET /activities/{id}` - activity details

**Resources:**
- [Strava API Docs](https://developers.strava.com/docs/)
- [Getting Started Guide](https://developers.strava.com/docs/getting-started/)

**To implement:** Create a setup guide for OAuth, store token securely, add fetch step before journal parsing.

---

### TODO: Garmin Connect Integration

Garmin's official API requires partner approval. Alternatives:

**Option A: python-garminconnect library**
- Unofficial but well-maintained Python wrapper
- GitHub: https://github.com/cyberjunky/python-garminconnect
- Supports: heart rate, sleep, stress, activities, body composition

**Example usage:**
```python
from garminconnect import Garmin
client = Garmin("email", "password")
client.login()
activities = client.get_activities(0, 10)  # last 10 activities
```

**Option B: GDPR data export**
- Garmin allows bulk export of all data
- One-time download, not automated
- Good for historical analysis

**Option C: Terra API**
- Third-party aggregator (https://tryterra.co/integrations/garmin)
- Normalizes data from multiple fitness platforms
- Requires subscription

**Useful Garmin data for workout planning:**
- Training status & load
- Recovery time estimates
- Sleep quality (affects workout readiness)
- Resting heart rate trends
- VO2 max estimates

**To implement:** Test python-garminconnect, add health metrics summary to weekly review.

---

### TODO: Combined Health Dashboard

Once integrations are working, add a "readiness" section:

```
## Weekly Health Context
- Avg sleep: X hrs (from Garmin)
- Avg resting HR: X bpm
- Training load: [status]
- Strava activities: X runs, Y rides
- Journal workouts: Z logged

## Readiness Assessment
[Based on sleep, recovery, recent load - suggest intensity for the week]
```

---

## Voice & Tone

Keep it practical and encouraging:
- Acknowledge what was accomplished, not just gaps
- Suggestions, not prescriptions - the user knows their body
- Be honest when data is sparse: "Hard to tell from the notes, but..."
- Keep summaries scannable - bullets over paragraphs
- Light nudges toward balance and recovery

**Good:**
- "Solid week - 5 days logged. Noticed lots of upper body; maybe some leg work Thursday?"
- "Only 2 workouts noted, but that's fine if life was busy. Here's a flexible plan..."

**Avoid:**
- Preachy fitness advice
- Assuming goals (unless stated)
- Over-analyzing sparse data

## Output

Final output should include:

1. **Workout Summary** - what was logged this week
2. **Observations** - patterns, gaps, wins
3. **Suggested Plan** - flexible framework for next week
4. **Questions** - check goals/constraints before finalizing

Keep it concise - this is a planning tool, not a fitness lecture.
