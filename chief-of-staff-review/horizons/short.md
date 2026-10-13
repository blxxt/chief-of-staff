# Horizon: Short (0–12 months)

**Reads in:** ~10 minutes
**Question it answers:** What should the CEO do this quarter / this month?
**Default cadence:** weekly to monthly
**Length target:** ~1500 words, 1-sentence "If you only read one thing," 3 TL;DR bullets, **1–3 decisions with top bolded**

**Depth posture:** brain-first. Read pre-digested daily ingest (`ingest/gmail/`, `ingest/calendar/`, `ingest/slack/`, `ingest/github/`). Fan out subagents only for *delta since the digest was written* and for AI leverage. The disproportionate value here is in catching the thing on fire that no one has escalated yet — not in token volume.

---

## What this horizon is for

Operational steering. The CEO knows the strategy; they need to know which of this quarter's bets are working, which are stuck, which threads in their inbox are festering, and where their actual time is going vs where it should go.

---

## Data weight

| Source | Weight |
|---|---|
| Recent Slack / email decisions | high |
| Calendar (time allocation) | high |
| Financial snapshot (runway, burn, MRR/ARR delta) | high |
| In-flight bets status | high |
| Customer voice (support, win/loss, NPS, churn reasons) | high |
| Org health (regrettable attrition, key-person risk, 1:1 cadence) | high |
| Customer / pipeline signals | medium |
| Competitive moves in last 30 days | medium |
| GitHub / shipping cadence | medium |
| AI capability trajectory (adoption mode) | medium |
| SWOT (0–12 mo, stage/financials + constraints emphasis) | medium |
| Long-arc trends | skip — wrong horizon |
| Industry futurology | skip — wrong horizon |
| AI frontier / restructure | skip — use medium+ |

---

## Inputs to gather

**Read ingest first.** For each bullet below, check `~/.claude/chief-of-staff/projects/<P>/ingest/<source>/` for a digest within the freshness target ([../sources/ingest.md](../sources/ingest.md)). Use the digest as the primary input. Spawn a Haiku subagent only for *what changed in the last few hours* if the horizon needs sub-day granularity. Each subagent returns ≤500 words plus the grammar-constrained `findings` block. See [../sources/internal.md](../sources/internal.md) and [../sources/external.md](../sources/external.md) for templates.

- **Inbox & comms triage** — Gmail + Slack: unresolved threads with investors / board / top customers / direct reports; escalations from the last 14 days.
- **Calendar audit** — last 4 weeks: % of working hours on customers / hiring / fundraising / product / internal / unstructured. Flag mismatch with the CEO's stated focus.
- **Financial snapshot** — runway months, MoM burn, MRR/ARR delta vs plan, top variance line items. See [../sources/financials.md](../sources/financials.md).
- **In-flight bets** — for each named bet from the prior short report: status (green/yellow/red), blocker, owner, what slipped, what changed.
- **Customer voice** — see [../sources/customer-voice.md](../sources/customer-voice.md). Always re-run. Top-3 support escalations from last 7 days, churn reasons from cancelled accounts, NPS verbatims (not score), most recent 3 sales calls' verbatim objections. **Must nominate one specific customer for the CEO to call this week** with the exact topic.
- **Org health** — see [../sources/org-health.md](../sources/org-health.md). Always re-run. Regrettable attrition last 30 days, key-person dependencies, hiring velocity vs plan, span-of-control outliers, directs whose last 1:1 was >2 weeks ago.
- **Competitive moves (30 days)** — funding rounds, product launches, exec hires, pricing changes. Use the `last30days` skill.
- **Shipping cadence** — `gh` CLI: PR throughput vs last 4 weeks, releases shipped, large stalled PRs.
- **AI ops / workflow audit (adoption mode)** — see [../sources/ai-leverage.md](../sources/ai-leverage.md). Question: which recurring workflows, support escalations, or CEO time-sinks could be 80%-replaced by current production AI tooling this quarter? Include shadow-AI signal from Slack/Gmail (where the team is already pasting outputs or sharing prompts — that's a leading indicator). Cost-of-delay measured in weeks of wasted headcount or missed margin.
- **SWOT (tight, 0–12 mo)** — see [../sources/swot.md](../sources/swot.md). 3 points per quadrant, lens emphasis on `[stage/financials]`, `[constraints]`, `[talent]`, plus the mandatory `[AI cross-cut]` per quadrant. Focus on near-term realities: cash, partnerships at risk, key-person dependencies, regulatory windows opening or closing this year. Skip 5-year industry-reshape framing — that's the long horizon's job.

---

## Questions every short report must answer

1. What changed since the last short report? (delta, not snapshot)
2. What decision is the CEO avoiding?
3. What is the CEO spending time on that they shouldn't be?
4. What is on fire that no one has escalated yet?
5. What is going better than expected and deserves more investment?
6. Are we augmenting an existing workflow with AI when, in the near term, we should be replacing the workflow outright?

---

## Avoid at this horizon

- Multi-year speculation
- Industry trend essays
- Anything the CEO can read directly off a dashboard they already check
- Recommendations that take 6+ months to land
- Caveats about the long-term future — those belong in long/grand reports
- AI frontier / restructure framing — adoption only at this horizon for AI Leverage. Lab-only capabilities do not belong here.
- SWOT points beyond the 12-month window — anything that resolves >12 mo out belongs in medium/long.

---

## Output specifics

- **If you only read one thing:** one sentence above TL;DR. No caveats.
- **Mode line:** wartime / peacetime + default-alive / default-dead verdict. If "default dead," that's the lede.
- **Prior briefing verdict:** scored before today's recommendations are taken seriously.
- **TL;DR:** 3 bullets. The most important thing first.
- **Decisions:** **1–3, top one bolded.** Each tagged Type 1 / Type 2; Type 1 decisions carry a 2-sentence pre-mortem. The top decision carries the anti-cowardice triple (steelman / named person / competitor mirror).
- **Inflection Watch:** 0–3 items. If none qualify, say "No inflection signal this run."
- **Short-horizon forcing functions** (mandatory): What to ship by Friday, Customer to call this week, Time-vs-priorities delta, Board exposure, Stop-doing list.
- **Who to ask this week:** one line per stale source — name the human, not the dataset.
- **Opportunities:** ≤3. Asymmetric upside the CEO may not be tracking this week.
- **Risks:** ≤3. Things not yet on fire but with a clear leading indicator.
- **In-flight bets table:** every named bet from the prior short report gets a row.
- **Callbacks:** mandatory — short-horizon reports are about delta, not snapshot.
