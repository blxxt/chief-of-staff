# Sources: Ingest (Cron Contracts)

Source ingestion happens **between briefings**, on a schedule, via cron-triggered Haiku jobs that write pre-digested markdown into `~/.claude/chief-of-staff/projects/<P>/ingest/<source>/YYYY-MM-DD.md`. The briefing skill reads these digests instead of pulling connector traversal inline.

This is the load-bearing efficiency move: connector cost is amortized across all briefings between two cron runs, not paid every time the CEO asks for a briefing.

---

## Why this matters

A short-horizon briefing that calls 8 fan-out subagents to traverse Gmail / Calendar / Slack / GitHub / etc. from scratch will:

- Take longer to run (cold connectors, rate-limited APIs).
- Cost more per briefing (raw traversal pays for every token of every email).
- Drift across briefings (each run re-derives the same context).
- Be shallower (subagents under wall-clock pressure cut corners).

A short-horizon briefing that reads `ingest/gmail/2026-05-13.md` instead:

- Reads a curated, clustered, already-cited summary.
- Lets the Opus synthesis layer focus on cross-source pattern detection, not raw extraction.
- Costs the same regardless of inbox size.
- Improves over time as the ingest prompt is tuned by curator feedback.

---

## Freshness targets per horizon

The freshness gate in `SKILL.md` step 3 uses this table. If the newest file in `ingest/<source>/` is older than the target, the briefing surfaces it in **What I couldn't see**.

| Source | Short | Medium | Long | Grand |
|---|---|---|---|---|
| Gmail | 1 day | 7 days | 30 days | 90 days |
| Calendar | 1 day | 7 days | n/a | n/a |
| Slack | 1 day | 7 days | 30 days | n/a |
| GitHub | 1 day | 7 days | 30 days | n/a |
| Financials | 7 days | 14 days | 30 days | 90 days |
| External (competitive + market) | 7 days | 14 days | 30 days | 90 days |
| AI leverage | always re-pull at briefing time (capabilities shift weekly) | — | — | — |

Sources marked `n/a` aren't load-bearing at that horizon.

---

## Per-source cron contract

Each scheduled ingest job is responsible for **one source**. The job runs on a cadence, hits the underlying MCP / API / CLI, and writes a single dated markdown file to `~/.claude/chief-of-staff/projects/<P>/ingest/<source>/YYYY-MM-DD.md`.

**Output schema** every ingest file must follow:

```markdown
---
source: <source-name>
window_start: <YYYY-MM-DD>
window_end: <YYYY-MM-DD>
generated_at: <YYYY-MM-DD HH:MM>
model: claude-haiku-4-5-20251001
prior_digest: <path or "none">
---

# <Source> digest — <window>

## Highlights

(Top 5–10 cross-cutting findings, clustered. Each cited.)

- **<one-line claim>** — <citation>

## By topic / cluster

### <Cluster name>

- <bullet> — <citation>

### <Cluster name>

- <bullet> — <citation>

## New entities mentioned

(Names, companies, projects that did not appear in `prior_digest`. Used by curator to spawn entity pages.)

- **<name>** (<type: person / company / project>) — <one-line context> — <citation>

## Delta vs prior digest

(What changed since the prior digest. Curator uses this to detect drift and patch entity pages.)

- <delta> — <citation>
```

**Hard rules:**

1. **Cite every claim** with the raw source URL / message ID / timestamp.
2. **No PII bodies** — summarize at the topic level. Names are OK; private message content is not.
3. **Dedup against `prior_digest`** — do not re-surface a finding from yesterday unless it materially advanced.
4. **Stay within the source.** A Gmail digest does not editorialize about strategy. It surfaces signal; synthesis happens at briefing time.

---

## Suggested cron schedule

These are recommendations the CEO can adjust. Schedule via `/schedule` (which writes a cron entry that fires `claude-code` headless with the matching prompt).

| Source | Frequency | Reason |
|---|---|---|
| Gmail | Daily, 06:00 local | Short-horizon freshness target is 1 day. |
| Calendar | Daily, 06:00 local | Same. Plus calendar churns fast inside the working day. |
| Slack | Daily, 06:00 local | Same. |
| GitHub | Daily, 06:00 local | Captures yesterday's PR / release motion. |
| Financials | Weekly, Monday 06:00 | Most financial systems update daily but financial volatility on a 1-day window is noise. |
| External (competitive + market) | Weekly, Monday 07:00 | `last30days` skill + targeted competitor changelog pulls. |

Schedule the **curator** (`/chief-of-staff-curate`) at least **30 minutes after** the slowest weekly ingest finishes, so it can consolidate fresh ingest into entity pages.

---

## Ingest job prompt template

Each scheduled job is a thin wrapper around this prompt, parameterized by source:

> You are the **<source>** ingest job for the chief-of-staff brain.
>
> **Window:** `<YYYY-MM-DD>` to `<YYYY-MM-DD>` (typically last 24h for daily, last 7d for weekly).
> **Prior digest:** `<path to most recent prior digest, or "none">`. Read it first to know what's already covered.
> **Output path:** `~/.claude/chief-of-staff/projects/<P>/ingest/<source>/<today>.md`. Overwrite if it exists.
> **Model:** Haiku (this is amortized work; do not use Opus).
> **Word budget:** ≤2000 words.
>
> Per the source-specific playbook in `sources/internal.md` or `sources/external.md`, pull what's in scope for the window. Cluster, dedup, cite, redact PII bodies. Write the output following the schema in `sources/ingest.md`.
>
> If you find a new named person, company, or project that does not appear in the prior digest **or** in any `~/.claude/chief-of-staff/projects/<P>/entities/` page, list it under "New entities mentioned" with a one-line context. The curator will turn these into entity pages.
>
> Do not synthesize across sources — that is the briefing skill's job and the curator's job. Stay scoped to **<source>**.

---

## What ingest does *not* do

- **Does not write entity pages.** That's the curator's job. Ingest just lists candidates under "New entities mentioned."
- **Does not write `recurring-themes.md`.** Curator job.
- **Does not synthesize across sources.** Briefing skill's job.
- **Does not run during a briefing.** Briefing reads digests; if a digest is stale, the briefing flags it — the briefing does not turn into an ingest run mid-stream unless the CEO explicitly asks (see freshness gate).

This separation of concerns is what keeps each layer's cost predictable: ingest is bounded-cost-per-day, curator is bounded-cost-per-cadence, briefing is bounded-cost-per-CEO-ask.

---

## Bootstrapping

When the CEO first sets up the skill, no ingest exists yet. The first briefing can either:

1. **Run inline** (slower, costlier, but works). The skill spawns one subagent per source per `sources/internal.md` etc. This is the legacy behavior.
2. **Bootstrap ingest first.** Tell the CEO: "I'm about to run a backfill of the last 7 / 30 / 90 days of ingest for the configured sources. This will take ~10 minutes and cost ~$X. After that, future briefings will be faster and deeper because they read pre-digested ingest." Then run the ingest jobs once over the bootstrap window before producing the briefing.

Recommend (2) for medium / long / grand briefings; (1) is acceptable for the first short briefing.
