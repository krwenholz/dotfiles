---
name: workout
description: "Weekly workout review and planning. Parses journal entries for workout logs, summarizes recent activity, and helps plan the next week. Use when the user types /workout or asks about their workout history/planning."
---

# Weekly Workout Review & Planner

Parse journal entries for workout data, review recent activity patterns, and help plan the upcoming week's training.

## Configuration

- **Journal location**: `~/journal/`
- **Journal file pattern**: `YYYY-MM-DD.md` (e.g., `2026-01-20.md`)
- **Workout section marker**: `# Workout` (H1 header)
- **Review period**: Last 7 days by default for weekly planning

**Directory structure:**
```
~/journal/
├── 2026-01-20.md
├── 2026-01-19.md
├── ...
├── weekly-design/     # Weekly planning docs (ignore for workout parsing)
├── yearly-design/     # Yearly reviews (ignore for workout parsing)
└── TEMPLATE           # Template file (ignore)
```

### Available Equipment

**LA Fitness:**
- Stationary bike
- Pool (swimming)
- Battle ropes
- Pull-up bar
- Slam balls
- Kettlebells
- Plyo boxes

**Home gym:**
- Gymnastic rings
- Kettlebells
- 40 lb slam ball
- Dumbbells (5-45 lb range)
- Jump rope
- Plyo box
- Weight bench
- Resistance bands

**Outdoor (weather permitting):**
- Road bike - only suggest when weather is decent (no rain, ice, or extreme conditions)

When suggesting exercises, prefer equipment the user actually has. For home workouts, stick to home gym equipment. For gym days, can use LA Fitness equipment.

## Process

### Step 1: Find Recent Journal Files

List journal files from the last 7 days:
```bash
# Get files matching date pattern in ~/journal/
ls ~/journal/????-??-??.md 2>/dev/null | sort -r | head -14
```

Only parse files directly in `~/journal/` - skip subdirectories like `weekly-design/` and `yearly-design/`.

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

### TODO: Exercise Reference Database

Use the free-exercise-db for offline exercise lookup and suggestions.

**Source:** [yuhonas/free-exercise-db](https://github.com/yuhonas/free-exercise-db)
- **License:** Unlicense (public domain)
- **Count:** 800+ exercises
- **Format:** JSON

**Download for offline use:**
```bash
mkdir -p ~/.local/share/workout-data
curl -o ~/.local/share/workout-data/exercises.json \
  https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/dist/exercises.json
```

**Data structure per exercise:**
```json
{
  "id": "...",
  "name": "Barbell Bench Press",
  "force": "push",
  "mechanic": "compound",
  "equipment": "barbell",
  "primaryMuscles": ["chest"],
  "secondaryMuscles": ["shoulders", "triceps"],
  "instructions": ["Step 1...", "Step 2..."],
  "category": "strength",
  "level": "intermediate"
}
```

**Use cases:**
- Suggest exercises targeting neglected muscle groups
- Provide alternatives if user lacks certain equipment
- Show proper form instructions for logged exercises
- Build balanced workout plans by muscle group coverage

**To implement:** Download JSON, add lookup function, integrate into planning step to suggest specific exercises.

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
