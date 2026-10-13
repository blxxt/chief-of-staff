# Horizon: Long (3–5 years)

**Reads in:** ~25–30 minutes
**Question it answers:** Where is this industry going and where should we be in it?
**Default cadence:** quarterly to semi-annually
**Length target:** ~4000 words, 3 TL;DR bullets, ≤5 decisions

**Depth posture:** brain-first, depth-maximized. Read every `entities/themes/<slug>.md` page, every `entities/companies/` page for named competitors, the last 2–4 long-horizon briefings, and `recurring-themes.md`. Then fan out aggressively for industry trajectory, technology S-curves, AI frontier SWOT, and adjacent-markets research. Per-run token cost is not a constraint at this horizon — the value of getting the 5-year direction right dwarfs any plausible inference bill.

---

## What this horizon is for

Trajectory and defensibility. Markets reshape on 3–5 year cycles — that's the cadence of platform shifts, regulatory regimes, and capital cycles. The CEO needs to know whether the company is positioned for the world that will exist in 2030 or the one that existed in 2024.

---

## Data weight

| Source | Weight |
|---|---|
| Industry analyst reports & M&A activity | high |
| Technology S-curves (what is becoming infrastructure) | high |
| Defensibility audit (moats) | high |
| Capital strategy (private vs IPO vs M&A path) | high |
| Talent strategy (scarce roles) | medium |
| Adjacent markets we could enter | medium |
| Markets to refuse | medium |
| AI frontier trajectory + restructure | high |
| Nth-order tech AI is accelerating (sim, robotics, bio, materials) | high |
| SWOT (3–5 yr, industry-reshape + technology + regulatory + AI cross-cut) | high |
| Quarterly noise | skip — wrong horizon |

---

## Inputs to gather

Spawn subagents in parallel. Each returns ≤1000 words with citations.

- **Industry trajectory** — analyst reports (Gartner, Forrester, a16z, Stratechery), public-company earnings transcripts in the space. Where is the puck going? Who agrees, who dissents?
- **Technology S-curves** — what is on the rising edge of an S-curve that will become commodity infrastructure in 3–5 years? What does that mean for our moat?
- **Defensibility audit** — for each claimed moat (data, network effects, brand, switching costs, distribution), how strong is it actually, and what would a well-funded competitor need to overcome it?
- **Capital strategy** — at our current trajectory, what's the realistic 3–5 year exit picture (IPO threshold, acquirer landscape, secondary path)? What would have to be true to have optionality?
- **Talent strategy** — which 5–10 specific people in the industry could change our trajectory if we hired them? What would make us magnetic to them?
- **Adjacent markets** — for each adjacent market we *could* enter, what is its size, our right-to-win, and the opportunity cost of pursuing it?
- **Markets to refuse** — markets that look adjacent but would dilute the company. Name them explicitly so the CEO can decline cleanly when the next pitch arrives.
- **AI frontier + restructure** — see [../sources/ai-leverage.md](../sources/ai-leverage.md). Two questions in one subagent: (a) **Frontier:** given likely 3–5 year AI trajectory (open-source LLM parity with frontier closed models, agentic systems, multimodal/video, long-context memory, sub-cent inference, world models for physics/chem/bio simulation, robotics foundation models), which of our currently-defensible moats erode and which previously-impossible products become possible? (b) **Restructure (mandatory):** if we re-founded this company today, AI-native, knowing what we now know, what is the 5-year plan that the current one doesn't have? Which lines of business, partnerships, or org shapes would not exist in the AI-native version? Produce ≥5 restructure findings, each naming the specific pre-AI assumption and the current dependent state. Name the 5-year AI-native competitor we don't take seriously today.
- **Nth-order tech accelerated by AI** — pick the 1–3 adjacent technology trajectories that compound for or against this company because AI is making them possible (e.g. simulation-driven R&D for atoms-domain companies, self-hosting / local-first architectures as open-source models reach parity, robotics for ops-heavy businesses, drug / materials discovery cycle compression). Each gets a primary-source citation and a company-specific implication.
- **SWOT (3–5 yr)** — see [../sources/swot.md](../sources/swot.md). 5 points per quadrant, lens emphasis on `[industry]` reshape, `[technology]` S-curves, `[constraints]` regulatory, plus the mandatory `[AI cross-cut]` per quadrant. Force partnerships-and-agreements review against the 5-year window: which contracts and exclusivities will be net-negative if held to term?

---

## Questions every long report must answer

1. What does our industry look like in 2030 that doesn't look like it today?
2. Which of our current moats will erode by then, and what's replacing them?
3. What capital path gives us the most optionality at year 5?
4. Who is the 5-year competitor we don't take seriously yet?
5. What is the cost of *not* deciding on the 5-year direction this quarter?
6. If we re-founded this company today, AI-native, what would the 5-year plan look like that the current one doesn't? Name 3 things we would stop doing immediately.

---

## Avoid at this horizon

- Quarterly tactical issues
- "Trends" lists without point of view — every trend gets an implication for *this* company
- Recommendations the CEO can defer for another year — at this horizon, indecision compounds

---

## Output specifics

- **TL;DR:** 3 bullets framed around a 5-year trajectory, not a quarter.
- **Decisions:** ≤5. Each with a recommendation. "Cost of delay" measured in **years**.
- **Opportunities:** structural — investments now that pay off as the market reshapes.
- **Risks:** moats that will erode, competitive entrants that don't look threatening yet but will.
- **In-flight bets table:** long-horizon bets only (multi-year initiatives).
- **Callbacks:** required — at this horizon, the *trajectory* of prior recommendations matters as much as the current ones.
