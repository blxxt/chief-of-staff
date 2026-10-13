# Sources: Internal

How to pull from each internal source.

---

## Read ingest first

For every source below, the briefing skill must **read the most recent `~/.claude/chief-of-staff/projects/<P>/ingest/<source>/YYYY-MM-DD.md` first** before deciding whether to spawn a fresh subagent. See [ingest.md](ingest.md) for the cron contracts and freshness targets.

Only fan out a fresh subagent when one of:

- No digest exists for the source.
- The latest digest is older than the horizon's freshness target.
- The horizon requires a *delta since the digest* pull (typically only short).
- The CEO's stated focus area is not covered in the digest.

When you do fan out, every subagent prompt must include the relevant digest excerpt and the relevant entity-page excerpts (the **brain-first rule** from [synthesis.md](synthesis.md)) so the subagent looks for what's new, not what's already known.

Every fan-out subagent returns the grammar-constrained `findings` block from [synthesis.md](synthesis.md), plus ≤500–1500 words of commentary. **Never read raw data into the main context.**

---

## Subagent prompt template

Use this skeleton for every per-source subagent. Vary only the bracketed fields.

> You are researching one slice of a chief-of-staff briefing for the CEO.
>
> **Horizon:** <short / medium / long / grand vision>
> **CEO focus areas:** <from step 1>
> **Source:** <e.g. Google Drive>
> **Question you must answer:** <one specific question>
> **Word budget:** ≤<N> words
> **Model:** Haiku (this is a fan-out subagent; do not escalate to Opus).
> **What I already know (do not re-derive):**
> ```
> <paste from the most recent ingest digest + relevant entity pages>
> ```
>
> Look for **what is new or what contradicts the above**. If the answer is "nothing new, the existing brain is still accurate," return one finding with `novelty: 1` saying so — that is a valid and useful result.
>
> Return the grammar-constrained `findings` block per `sources/synthesis.md` followed by inline-cited commentary. Do not editorialize beyond "why it matters." Do not include raw quotes longer than 2 lines. Do not include PII unless directly load-bearing (and even then, redact where possible).

---

## Google Drive (Docs / Sheets / Slides)

**Tool:** `claude.ai Google Drive` MCP server. Authenticate on first use; if auth is missing, surface a one-line prompt to the CEO and continue with what you have.

**Search patterns by horizon:**

- **Short:** `OKR`, `weekly update`, `board update`, `financial model`, `Q<n> plan` — last 60 days
- **Medium:** `strategy`, `roadmap`, `18 month`, `hiring plan`, `fundraise` — last 180 days
- **Long:** `5 year`, `long term`, `moat`, `vision`, `market` — full history
- **Grand vision:** `mission`, `vision`, `why now`, `founding`, `manifesto`, `memo` — full history

**Cite:** doc URL (clickable) + section heading.

---

## Gmail

**Tool:** `claude.ai Gmail` MCP server.

**Search patterns:**
- Threads to/from investor / board / top-customer / candidate domains
- Threads tagged "important" or starred
- Unanswered threads where CEO is on To: last 14 days (short horizon)
- Threads with attachments labeled "deck", "plan", "memo"

**Privacy:** never include the body of personal / HR threads. Summarize at the topic level. Cite by sender + date.

---

## Google Calendar

**Tool:** `claude.ai Google Calendar` MCP server.

**Pull:** last 4 weeks (short), 12 weeks (medium), N/A (long/grand).

**Process:** bucket events into categories (customer, hiring, fundraising, product/eng, internal, 1:1, unstructured). Report % of working hours per bucket. Flag the biggest delta vs the prior period and vs the CEO's stated focus areas (from `profile.md`).

**Cite:** event title + date. Do not include attendee lists in the report.

---

## GitHub

**Tool:** `gh` CLI (no MCP needed).

**Useful commands:**
```bash
gh pr list --state open --limit 50 --json title,number,author,createdAt,labels,updatedAt
gh issue list --state open --label strategic --limit 50
gh api repos/{owner}/{repo}/releases --jq '.[0:5]'
gh search prs --author "<eng-lead>" --created ">$(date -v-30d +%Y-%m-%d)"
```

**Look for:** stalled strategic PRs, release cadence delta, named stuck issues, change in shipping velocity per team member.

**Cite:** PR/issue URLs, commit SHAs.

---

## Slack

**Tool:** Slack MCP if configured. If not, note "Slack not configured" in the report's "What I couldn't see" section and continue.

**Pull from:** `#leadership`, `#strategy`, `#execs`, `#fires` (or equivalents); CEO DMs if accessible.

**Look for:** unanswered exec threads >7 days, escalations with no owner, decisions that were debated but never resolved, topics that keep recurring without progress.

**Cite:** channel + ISO timestamp.

---

## Figma

**Tool:** Figma MCP if configured. If not, skip.

**Useful for:** medium / long horizons — what is being designed that hasn't been built? Where is design attention going vs the product roadmap?

**Cite:** file URL + frame name.

---

## Asana / Linear / Jira

**Tool:** matching MCP if configured.

**Pull:** blocked tasks >14 days, stalled epics, recently-deprioritized work, sprint completion rate trend.

**Cite:** ticket URL.

---

## CRM (Salesforce / HubSpot)

**Tool:** matching MCP if configured.

**Pull:** pipeline movement, top stalled deals, win/loss reasons in the last quarter, named at-risk customers (short / medium horizons only).

**Cite:** record URL. **Never** include unredacted customer PII in the report.

---

## Product analytics (Mixpanel / Amplitude / PostHog)

**Tool:** matching MCP or CSV export if available.

**Pull:** retention curves, top-event trends, funnel deltas. Useful at short / medium for product-market signal.

**Cite:** dashboard URL + date range.

---

## Missing-source policy

If a source is not configured, do not fake it. Add a one-line entry to the report's **"What I couldn't see"** section:

> Slack: not configured. Recommend installing the Slack MCP to unblock the "unresolved exec threads" signal in future short-horizon reports.

This both flags the gap and gives the CEO an actionable next step.
