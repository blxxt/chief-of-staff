# Chief of Staff for Your CEO Brain

A two-skill system that gives a CEO a chief of staff who remembers everything, prepares between briefings, and gets sharper over time instead of duller.

You ask. It briefs. The briefing gets better every time because of the work that happens **between** briefings.

---

## What you get

- **Strategic briefings** across four time horizons — short (this quarter), medium (18 months), long (5 years), grand vision (10–20 years). One skill, four playbooks.
- **A persistent brain** at `~/.claude/chief-of-staff/` — markdown files you can read, edit, grep, or back up. Synthesis on top, audit trail below. No black-box vector store.
- **Background ingestion** — your Gmail, Calendar, Slack, GitHub, and financials get pre-digested on a schedule, so briefings read a curated summary instead of re-traversing raw data every time.
- **Between-briefing curation** — a separate skill consolidates new findings into the brain on a cadence, so every briefing starts from accumulated truth, not a cold read.

---

## The three pieces

```
You ask for a briefing
        │
        ▼
┌──────────────────┐    reads     ┌──────────────────────┐
│ chief-of-staff   │◀─────────────│ The Brain            │
│ -review (skill)  │              │ ~/.claude/chief-of-  │
│ "the briefing"   │   patches    │ staff/               │
└──────────────────┘─────────────▶│ • entities/          │
                                  │ • briefings/         │
┌──────────────────┐    patches   │ • ingest/            │
│ chief-of-staff   │─────────────▶│ • feedback/          │
│ -curate (skill)  │              │ • recurring-themes   │
│ "the curator"    │              └──────────────────────┘
└──────────────────┘                       ▲
   (scheduled)                             │ writes
                                           │
                                  ┌──────────────────┐
                                  │ Ingest cron jobs │
                                  │ Gmail, Calendar, │
                                  │ Slack, GitHub,   │
                                  │ Financials,      │
                                  │ External         │
                                  └──────────────────┘
                                  (scheduled, Haiku)
```

1. **The briefing** (`chief-of-staff-review`) is what you invoke when you want a report. It reads the brain, fans out subagents only for what's actually new, and synthesizes a briefing for you to read.

2. **The brain** is a folder of markdown files. Each person, company, theme, and decision gets its own page with a "current truth" section on top and an append-only timeline below it. Everything is human-readable. You can `cat` it, `grep` it, or open it in any editor.

3. **The curator** (`chief-of-staff-curate`) is a separate skill that runs on a schedule. It folds new ingest and new briefings into the brain, dedups findings, notices patterns across briefings, and surfaces stale decisions. The heavy thinking happens here, on a cheap model, in the background — so the per-briefing experience stays fast and deep.

Optional but recommended: **ingest cron jobs** for Gmail / Calendar / Slack / GitHub / financials / external. Each one runs on its own schedule and drops a pre-digested markdown summary into `~/.claude/chief-of-staff/ingest/<source>/<date>.md`. Without these, the briefing skill falls back to pulling raw connector data inline (slower, costlier, shallower).

---

## First-time setup (15 minutes)

### 1. Run the first briefing

Just ask. In Claude Code or Claude.ai:

> Give me a chief of staff review.

The skill notices `~/.claude/chief-of-staff/` doesn't exist yet, creates it, and walks you through a profile (company, role, focus areas, AI posture, cadence preferences). Be honest — this becomes the system's lens.

After profile setup it produces the first briefing. The first one is the weakest; subsequent briefings compound.

### 2. Schedule the curator

The curator is the load-bearing piece. Without it, briefings re-derive the same context every time. Schedule it from inside Claude:

> Schedule chief-of-staff-curate daily at 04:00.

If `/schedule` isn't available, add a cron entry that invokes Claude Code headless:

```cron
0 4 * * * claude --skill chief-of-staff-curate >> ~/.claude/chief-of-staff/curator/cron.log 2>&1
```

A daily pass takes a few minutes. A weekly pass (Sundays or Mondays) does the deeper consolidation.

### 3. Schedule the ingest jobs

For each source you actually use, schedule a daily or weekly digest. See `sources/ingest.md` for the cron contracts. The simplest path is to ask Claude:

> Schedule Gmail / Calendar / Slack / GitHub ingest daily at 06:00. Schedule Financials and External ingest weekly at Monday 06:00.

You can do this incrementally — start with the ones whose MCPs you already have configured.

### 4. Connect data sources you care about

Open Claude's MCP settings and connect:

- **Google Drive / Gmail / Calendar** — required for short and medium horizons.
- **GitHub** (via `gh` CLI, no MCP needed) — required if you have engineering.
- **Slack** — strong signal for short horizon.
- **Stripe / QuickBooks / Mercury** — required for financials at all horizons.
- **CRM (Salesforce / HubSpot)** — useful for short/medium.
- **Linear / Asana / Jira** — useful for short/medium.

Missing sources don't break anything. The briefing's **What I couldn't see** section will tell you which gaps to close next.

---

## Day-to-day use

### Asking for a briefing

> Give me a short chief of staff review focused on fundraising.
>
> Brief me on the medium horizon — skip hiring this time.
>
> Long-horizon review. Free-form, you pick what matters.
>
> I'm wrestling with the 10-year question. Run a grand-vision review.

The skill will ask which horizon if you don't say, then ask if you want to weight any focus area. After that, it works.

**Rough wall-clock:**

| Horizon | Time | Length |
|---|---|---|
| Short | ~10 min | ~1500 words |
| Medium | ~15–20 min | ~2500 words |
| Long | ~25–30 min | ~4000 words |
| Grand vision | ~45–60 min | ~6000 words |

Token cost is intentionally **not** advertised here. The system is designed to deliver disproportionate value, not to minimize spend. If the architecture is set up right (curator scheduled, ingest scheduled), per-briefing cost is bounded and modest. If it isn't, briefings are still useful but cost and time go up.

### Reading a briefing

Every briefing follows the same structure. Read in this order if you only have 60 seconds:

1. **TL;DR** — 3 bullets. If the chief of staff did their job, this is the whole brief.
2. **Decisions you should make now** — each one has a recommendation. Not options. A recommendation.
3. **In-flight bets — status** — every bet from the prior briefing has a row with delta.
4. **The hardest thing I can say to you** (grand vision only) — read this last; it's the price of admission for that horizon.

The other sections (Opportunities, Risks, AI Leverage, What I Looked At, What I Couldn't See, Confidence, Callbacks) are there for you to audit and for the next briefing to pick up. Skim them; don't read every word.

### Giving feedback

After every briefing, the skill asks three questions:

1. What was the most useful part?
2. What did I miss, or get wrong?
3. What was wasted space — what should I cut next time?

**Be brutal.** Vague feedback produces vague briefings. The system saves your answers verbatim and folds them into the brain. If you say "stop spending three paragraphs on the macro environment at the short horizon," the next short briefing will not do that.

Feedback is the single biggest lever you have on briefing quality. Skipping it is the single biggest mistake.

### When you make a decision based on a briefing

Tell the skill explicitly:

> Based on this, I'm deciding to push the Series B raise to Q3 and prioritize the enterprise tier launch.

The skill creates a decision entity (`~/.claude/chief-of-staff/entities/decisions/<slug>.md`) and the next briefing of the matching horizon will check on it. Without this, decisions go undisciplined — you'll make them, but the system won't follow up.

---

## What lives in the brain

The brain has two layers: **operator** (one human, shared across every project you run) and **projects/<slug>** (one company/venture per slug). You can have one project or ten — the skill resolves which project's briefing you want from your cwd.

```
~/.claude/chief-of-staff/
├── operator/                          ← You — the human across all your projects
│   ├── operator-profile.md            ← Working style, feedback preference, time-horizon default
│   ├── ceo-patterns.md                ← Recurring blind spots (curator-maintained, accumulates across projects)
│   ├── recurring-themes.md            ← Cross-project operator-level patterns
│   ├── personas.md                    ← Per-project tone/voice (serious / personal / playful)
│   └── projects.json                  ← cwd → project-slug map
└── projects/<slug>/                   ← One per company/venture
    ├── profile.md                     ← Stage, ICP, runway, focus areas
    ├── index.md                       ← One line per past briefing
    ├── entities/
    │   ├── people/<slug>.md           ← Each person who matters to this project
    │   ├── companies/<slug>.md        ← Each company that matters (competitor, customer, partner, investor)
    │   ├── themes/<slug>.md           ← Each recurring theme (hiring-pipeline, fundraise-prep, ...)
    │   └── decisions/<slug>.md        ← Each active or historical decision, with follow-up status
    ├── ingest/<source>/<date>.md      ← Pre-digested daily/weekly summaries from your data sources
    ├── briefings/<date>-<horizon>.md  ← Every briefing the skill has produced for this project
    ├── feedback/<date>-<horizon>.md   ← Your feedback, verbatim, plus derived lessons
    └── curator/<date>.md              ← Per-project curator run logs
```

Every entity page has the same shape: **compiled truth above `---`** (rewritable, the system's current best understanding), **timeline below `---`** (append-only audit trail, never edited).

You can open any of these in an editor. If you correct the compiled-truth section by hand, the system will respect your edit and treat it as ground truth on the next run.

**Why two layers?** The operator layer is about *you* — your blind spots, your voice, how you take feedback. These travel with you across every venture; fragmenting them per-project would mean each silo's `ceo-patterns.md` never accumulates enough evidence to be load-bearing. The project layer is about *the business* — stage, runway, default-alive verdict, ICP — and that has to be isolated, because Acme as a competitor in Project A is not the same Acme as a customer in Project B.

**Migrating an existing single-tenant brain?** Run `scripts/migrate-to-projects.sh --slug <your-slug>` for a dry-run, then add `--execute`. It lifts operator-scoped files to `operator/`, moves the rest to `projects/<slug>/`, and seeds the operator skeletons.

---

## How the system saves you money

Briefings cost more per run than a typical Claude conversation because they read a lot. The system pays that cost back three ways:

1. **Decisions you make differently.** A short briefing that surfaces a fire no one has escalated yet pays for a year of inference in one save. Long and grand briefings are bets on direction; getting one of those right is worth a multi-million dollar swing.
2. **Time the CEO doesn't spend.** A 15-minute briefing that consolidates the equivalent of three hours of "what's going on with X" check-ins is a 12:1 trade in your time.
3. **Repeated-use compounding.** The brain accumulates. Briefing #20 reads briefing #1–19's conclusions and only goes deep on what's new. Cost-per-insight drops the longer you use it.

The architecture is built so that the *expensive* work (synthesis across sources, pattern detection, entity consolidation) happens on a **cheap model on a schedule** between briefings (the curator). The *valuable* work (the actual briefing you read) happens on the **best model**, focused on synthesis you couldn't get elsewhere.

---

## Operating notes

### Privacy & sensitive data

- Everything stays local. The brain is at `~/.claude/chief-of-staff/`. It is never uploaded to a third-party tool.
- Financial figures are never pasted into web searches.
- PII bodies are never included in briefings (names are; private message contents are not).
- The skill will refuse to send anything sensitive to external services unless you tell it to.

If you want to back up the brain: just back up the directory. It's all markdown.

### When briefings get worse

If you notice quality dropping, check in this order:

1. **Is the curator running?** Look at `~/.claude/chief-of-staff/projects/<slug>/curator/`. The most recent run should be within the last few days. If not, the brain isn't being consolidated; briefings will plateau.
2. **Is ingest fresh?** Each briefing's "What I couldn't see" section flags stale sources. If most of your sources are flagged, your scheduled ingest isn't running.
3. **Is feedback being captured?** Look at `~/.claude/chief-of-staff/projects/<slug>/feedback/`. If you've stopped answering the three questions, the system can't tune to you.
4. **Is the profile still accurate?** Open `~/.claude/chief-of-staff/projects/<slug>/profile.md`. If your stated focus areas are 18 months stale, the system is weighting the wrong things. (Cross-project facts about you live in `~/.claude/chief-of-staff/operator/operator-profile.md`.)

### When you want to look something up directly

The brain is searchable two ways:

```bash
# Fast FTS5 search across operator + every project (if scripts/index.sh has run):
~/.claude/skills/chief-of-staff-review/scripts/brain-search.sh "fundraise"

# Scope to one project:
~/.claude/skills/chief-of-staff-review/scripts/brain-search.sh "fundraise" --project acme

# Operator-layer only (cross-project blind spots / recurring themes):
~/.claude/skills/chief-of-staff-review/scripts/brain-search.sh "regulatory" --project operator

# Filter by entity kind:
~/.claude/skills/chief-of-staff-review/scripts/brain-search.sh "Acme" --kind company

# Fallback: ripgrep over the brain:
rg -i "fundraise" ~/.claude/chief-of-staff/
```

Or just open the folder in your editor.

### When you need to forget something

Edit or delete the markdown file directly. The system treats your edits as ground truth. If you delete an entity, the next briefing won't reference it. If you remove a timeline entry by hand, it's gone (though most edits should rewrite compiled-truth and leave the timeline intact, since the timeline is your audit trail).

If a sensitive thread shouldn't have been ingested, delete the ingest file and re-run the curator.

### What the skill will refuse to do

- It will not skip risks because you asked it to. It will name the risk once and then comply.
- It will not give you "options" without a recommendation. Strategy without a pick is not strategy.
- It will not soften an uncomfortable truth that's actionable. If hiring is behind plan and you said it was ahead, the briefing will say so with the measurement.
- It will not paraphrase paywalled articles. Links and abstracts only.

This is the failure mode of every "CEO assistant" product: it tells you what you want to hear. Push back hard if you feel that creeping in, and capture the correction as feedback so the system learns.

---

## Quick reference

| I want to… | Do this |
|---|---|
| Get a briefing | Ask: *"give me a chief of staff review"* |
| Pick a horizon up front | *"short / medium / long / grand vision review"* |
| Skip a topic | *"…skip hiring"* or *"…focus on fundraising"* |
| Tell the system I decided something | Just say it: *"based on this, I'm deciding X"* |
| Improve future briefings | Answer the three feedback questions honestly |
| Look something up directly | Open `~/.claude/chief-of-staff/` or use `brain-search.sh` |
| Edit what the system "knows" | Edit the markdown file directly |
| Stop the system from re-recommending something | Say "I've decided against X" — it'll respect that |
| Back up the brain | Copy `~/.claude/chief-of-staff/` anywhere |
| Reset the brain | `rm -rf ~/.claude/chief-of-staff/` and run a new briefing |

---

## Where the rules live

If you want to inspect or tune the skill itself:

- **Briefing skill:** `claude/skills/chief-of-staff-review/SKILL.md` — entry point and orchestration.
- **Per-horizon playbooks:** `claude/skills/chief-of-staff-review/horizons/*.md` — what each horizon weighs and asks.
- **Per-source playbooks:** `claude/skills/chief-of-staff-review/sources/*.md` — including `synthesis.md` (the synthesis rules and anti-cowardice posture) and `ingest.md` (the cron contracts).
- **Templates:** `claude/skills/chief-of-staff-review/templates/*.md` — briefing skeleton, entity-page formats.
- **Curator skill:** `claude/skills/chief-of-staff-curate/SKILL.md` — the between-briefing consolidation.

These are all markdown. Edit them and the next briefing picks up the change.

---

## The one thing not to skip

**Schedule the curator.** Without it, you have a briefing skill that re-derives context every time, which is the expensive, slow, shallow version of this system. With it, every briefing starts from accumulated truth and the value compounds the longer you use it.

That's the whole architectural argument. If you only do one piece of setup, do that one.
