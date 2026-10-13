# Org Health

**Always re-run per briefing at short/medium horizons. Once per quarter at long/grand.** Horowitz's rule of priorities — *"take care of the people, the products, and the profits, in that order"* — is missing from most CEO dashboards because people-data lives in HR systems CEOs don't open. This source surfaces it.

The CoS failure mode here is reporting on people the way a recruiter reports — as headcount math. The right framing is *load-bearing humans and where the load is shifting*.

---

## What this source surfaces

Every short/medium briefing receives:

1. **Regrettable attrition, last 90 days.** Names, roles, tenure, manager. Pattern check: clustered by team, by manager, by tenure cohort?
2. **Key-person risk.** Single points of failure — the engineer who is the only one who can deploy X, the AE who owns 40% of named-account ARR, the founder's-favorite who has no backup. Surface with the *specific risk*, not "we have key-person risk."
3. **Hiring velocity vs plan.** Open reqs past target start date (in weeks, not %). Funnel-stage stalls. Roles that have been open >60 days.
4. **Span-of-control outliers.** Managers with >10 directs (overloaded) or with 1–2 directs (probably should not be managers). Both are signals.
5. **1:1 cadence health.** CEO's directs and Eng-leadership directs whose most recent 1:1 was >2 weeks ago. Calendars are the source of truth here.
6. **Performance distribution.** If the company uses a performance system: who's a flight risk in the top quartile, who's tolerated in the bottom quartile. (Sensitive — see anti-noise rules.)
7. **Compensation pressure.** Anyone whose comp is materially below market for their role/level — leading indicator of regrettable attrition.
8. **Org-design tension.** Teams where the org chart disagrees with what people actually do. Surface via Slack channel ownership, on-call rotations, PR review patterns.

---

## The one mandatory output

**Name the load-bearing human at greatest risk in the next 90 days.** One name. The risk (offer they might accept, burnout, comp gap, missing recognition, missing growth path). The retention move available.

If there is no risk at all, say so explicitly — a quiet org is signal too. But it's also rare; usually the synthesizer hasn't looked hard enough.

---

## Subagent prompt template

```
You are an org-health subagent for a chief-of-staff briefing.

Inputs to walk:
- ~/.claude/chief-of-staff/projects/<P>/ingest/org-health/<latest>.md (pre-digested)
- HRIS data per profile.md (Rippling / Gusto / Workday / etc.)
- ATS data per profile.md (Greenhouse / Ashby / Lever / etc.)
- Calendar metadata (1:1 frequency by manager-direct pair)
- Slack channel-membership patterns
- GitHub PR-review patterns (eng leadership signal)

For each finding, return the grammar-constrained block from sources/synthesis.md including `strongest_counter`.

Mandatory: name exactly one load-bearing human at greatest risk in the next 90 days.
Return shape:
  load_bearing_at_risk:
    name: "<full name>"
    role: "<title>"
    risk: "<specific risk in one sentence>"
    retention_move: "<the move available to the CEO this week>"
    confidence: high | medium | low

Anti-noise: do not list people by tenure. Do not list people by performance rating alone. Do not invent risks.
```

---

## Freshness target

- **Short horizon:** ≤30 days for HRIS/ATS pulls; ≤7 days for calendar/Slack signal.
- **Medium horizon:** ≤30 days, with trend lines.
- **Long / grand:** quarterly snapshot.

---

## Anti-noise rules

1. **No "morale is low" without evidence.** Either cite the specific signal (Slack channel sentiment, retro themes, eNPS verbatims) or do not include it.
2. **No headcount math without humans.** "We are 4 ahead of plan on eng hires" is noise. "We are 4 ahead of plan on eng hires *and* the senior bar has dropped on the last 3 offers — see [doc]" is signal.
3. **Performance data is sensitive.** Never name a bottom-quartile performer by name in the briefing without first checking with the CEO that they want that surface. Top-quartile flight risks *should* be named — that's the actionable case.
4. **Calendar > stated cadence.** If the CEO says "I do weekly 1:1s with my directs" and the calendar shows the average gap is 17 days, surface the calendar reality.
5. **Track patterns across briefings.** The curator should note in `ceo-patterns.md` if the CEO routinely ignores attrition warnings, comp-pressure flags, or 1:1-cadence misses — those become standing checks.

---

## What this is *not*

- A people-ops dashboard. Slack already has one. The job here is *what's load-bearing and at risk*, not metrics for their own sake.
- A performance-review tool. Performance distribution is read; performance recommendations are not the CoS's job.
- A diversity report. That belongs in a separate scheduled briefing, not folded into strategic synthesis.
