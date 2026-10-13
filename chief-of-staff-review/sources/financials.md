# Sources: Financials

Financial data is the most sensitive and most decision-relevant source in any horizon. The chief of staff's job is to surface the **right numbers** for the chosen horizon, not to dump the P&L.

**Read the financials ingest digest first** (`~/.claude/chief-of-staff/projects/<P>/ingest/financials/YYYY-MM-DD.md`). The weekly financials ingest already pulls runway, burn, MRR/ARR, top variance lines, and aging. Re-pull live only when (a) the digest is older than the horizon's freshness target, or (b) the CEO is making a financial decision that requires same-day numbers.

---

## Configured sources

- **QuickBooks MCP** — P&L, balance sheet, cash flow
- **Stripe MCP** — revenue, MRR / ARR, churn
- **Mercury / Brex** — cash balance, burn (often via CSV export if no MCP)
- **Carta** — cap table, dilution model
- **Finance dashboards** (Causal, Mosaic, Finmark) — if CSV or API is reachable

## Unconfigured sources

If no API / MCP is available: ask the CEO or CFO once for the latest export. Recommend a recurring drop into a known Drive folder and pick it up automatically on future runs. **Note staleness explicitly** in the report:

> Financial snapshot as of 2026-04-30 — 13 days old.

---

## What each horizon needs

### Short (0–12 months)

| Metric | What to surface |
|---|---|
| Runway months | At current burn rate |
| Burn | MoM, last 3 months trend |
| MRR / ARR delta vs plan | % off and absolute $ |
| Cash balance | As of <date> |
| Top 3 OpEx variance lines | vs plan |
| Top 3 revenue drivers / drags | this month |
| Receivables aging | anything >60 days |

**Flag if:** runway < 12 months, burn growing >10% MoM, ARR plan miss >15%.

### Medium (12–36 months)

| Metric | What to surface |
|---|---|
| Runway vs next-milestone requirement | Do we have enough cash to hit the metrics required for the next raise? |
| Burn multiple trend | Capital efficiency |
| Magic number / payback period | For sales-led growth |
| Dilution math | For the next raise at expected valuation |
| OpEx mix | Hiring ahead of revenue or behind? |
| Plan revision history | How many times have we re-forecast in 6 months? (high count = strategy uncertainty) |

**Flag if:** burn multiple > 2, payback period > 18 months, plan revised 3+ times in 6 months.

### Long (3–5 years)

| Metric | What to surface |
|---|---|
| Capital strategy | Total raised so far, total likely needed to reach exit, dilution path |
| Unit economics at scale | What does the business look like at 10x revenue? At 100x? |
| Profitability path | Is there one — and what would have to break for it to materialize? |
| Exit comparables | What have similar-shaped companies exited for, and at what financial profile? |
| Capital efficiency vs benchmarks | Top quartile, median, or bottom quartile of comparable companies? |

### Grand vision (10–20+ years)

Financials are mostly **not** the right frame at this horizon. Pull only:

- **Total addressable wealth creation** if the mission is delivered
- **Required capital base** to operate at the mission's scale (e.g. "to build X, the company would need to be at $10B+ revenue scale, which implies Y capital path")
- **Profitability vs influence tradeoff** — at this scale, is the company optimized to make money or to shape the world? Both are legitimate. Naming which is the chief of staff's job.

---

## Sensitivity rules

1. **Financial figures stay in the local report.** Do not paste them into web searches, third-party tools, or any external system.
2. **Round to meaningful precision** — `runway: ~14 months` not `runway: 14.237 months`.
3. **Cite source and freshness** for every number: `MRR as of 2026-05-01 per Stripe MCP`.
4. **Lead with bad news.** If a number is materially worse than the CEO might expect, it goes in the TL;DR, not buried in section 7.
