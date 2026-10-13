# Horizon: Medium (12–36 months)

**Reads in:** ~15–20 minutes
**Question it answers:** What should we be building toward?
**Default cadence:** monthly to quarterly
**Length target:** ~2500 words, 3 TL;DR bullets, ≤5 decisions

**Depth posture:** brain-first, with weekly digest as floor. Read entity pages for the relevant themes (`entities/themes/<roadmap|hiring|fundraise|positioning>.md`) before deciding what to fan out. Fresh subagents for: positioning gap (customer language vs marketing), competitive landscape on the 90-day window, AI leverage (adoption + frontier).

---

## What this horizon is for

Strategic positioning over 1–3 years. The CEO is making bets that will pay off in 18 months — hiring, roadmap, capital, market positioning. They need a clear-eyed read on whether the current trajectory matches the destination.

---

## Data weight

| Source | Weight |
|---|---|
| Roadmap & strategy docs (Drive) | high |
| Hiring plan vs org chart | high |
| Competitive landscape (90-day window) | high |
| Customer language vs marketing language | high |
| Capital plan & dilution math | high |
| Regulatory direction | medium |
| Adjacent markets | medium |
| Technology compounding bets | medium |
| AI capability trajectory (adoption + frontier + restructure) | high |
| SWOT (12–36 mo, industry/talent/technology/distribution + AI cross-cut) | high |
| Daily ops | skip — wrong horizon |

---

## Inputs to gather

Spawn subagents in parallel. Each returns ≤700 words with citations.

- **Roadmap audit** — Drive: latest strategy memos, OKRs, board decks. Where does the roadmap commit us in 18 months? What capability does that require that we don't have yet?
- **Hiring plan vs reality** — current org chart vs target org chart at 18 months. Which roles need to be filled 9 months before they're "needed" because of ramp time? Where are the gaps that will bite us?
- **Positioning gap** — how customers describe the product (interviews, call recordings, support tickets) vs how we describe it on the homepage and in pitch decks. Where they diverge is where strategy is drifting.
- **Competitive landscape (90 days)** — who is gaining, losing, pivoting in our space. Careers pages, blog cadence, funding signals, exec moves.
- **Capital plan** — runway at current burn vs runway needed to hit the next financing milestone. Next raise size, expected dilution, alternatives (debt, slower growth, profitability path).
- **Technology compounding bets** — what would we need to start *now* (data accumulation, platform, integrations, hard-tech investment) to have a moat in 24 months?
- **Regulatory direction** — what's moving in our jurisdictions over the next 24 months that could open or close markets?
- **AI feature & cost-structure scan (adoption + frontier + restructure)** — see [../sources/ai-leverage.md](../sources/ai-leverage.md). Three questions in one subagent: (a) which AI-native feature is becoming table-stakes in our category that we lack, and what would a competitor ship in the next 12 months that we should pre-empt? (b) Given inference cost has dropped ~10× twice in 24 months, which parts of our cost structure or product economics shift materially if it drops again? (c) **Restructure:** if we re-founded this company today, AI-native, what would the 18-month roadmap look like that the current one doesn't? Which line items, partnerships, or product surfaces would not be on it? Produce ≥3 restructure findings, each naming a specific pre-AI assumption and the current dependent state. Distinguish capabilities that are commodity today from those expected to commoditize inside 18–24 months.
- **SWOT (12–36 mo)** — see [../sources/swot.md](../sources/swot.md). 4 points per quadrant, lens emphasis on `[industry]`, `[talent]`, `[technology]`, `[brand/distribution]`, plus the mandatory `[AI cross-cut]` per quadrant. Drive partnership / agreement / hiring-plan / capital-plan analysis here so Decisions has a structured surface to draw from.

---

## Questions every medium report must answer

1. Is the 18-month roadmap a real plan or a wishlist?
2. What capability do we lack that we need in 12–18 months and can't buy late?
3. Where is the strategy drifting away from what customers actually want?
4. What is the next financing milestone and are we on track for the metrics it requires?
5. Who is our most dangerous competitor 18 months from now — not today?
6. Are we shipping a competently AI-augmented version of the company when we should be restructuring it AI-native? Name what we would stop doing if we re-founded today.

---

## Avoid at this horizon

- Operational status (use short horizon)
- 5+ year speculation (use long horizon)
- Recommending the CEO "explore" something — recommend committing or killing
- Hedge-everything analysis — pick a direction; you can be wrong

---

## Output specifics

- **TL;DR:** 3 bullets framed around the 18-month destination, not the week.
- **Decisions:** ≤5. Each with a recommendation. "Cost of delay" measured in quarters.
- **Opportunities:** asymmetric bets that need to be started now to compound by month 18–24.
- **Risks:** capability gaps and competitive threats with a 6–12 month warning window.
- **In-flight bets table:** every named medium-horizon bet gets a row with delta vs prior report.
- **Callbacks:** mandatory — strategy is a multi-quarter conversation.
