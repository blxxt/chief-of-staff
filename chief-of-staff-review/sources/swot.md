# Sources: SWOT

A structured strategic read of *this* company, in *its* industry, at *its* stage, under *its* constraints — with AI's cross-cutting impact woven into every quadrant rather than siloed.

This is not a generic SWOT exercise. The output of this section feeds Decisions and Risks directly; if the SWOT is thin, the report is thin. Run SWOT at **every horizon**, scoped to that horizon's time window and the lenses that matter most for it.

---

## Why SWOT exists separately from AI Leverage

The AI Leverage section asks "what is AI doing to capabilities, and what should we do about it?" That is a forcing question, but it is *one* forcing question. A CEO running a real company also has to reason about:

- Industry structure (consolidation, fragmentation, regulatory regime, supply chain shape)
- Company stage and financial posture (cash runway, profitability, growth rate, unit economics)
- Constraints already baked in (existing partnerships, customer contracts, vendor lock-in, debt covenants, geographic regulation)
- Talent depth and concentration
- Technology / IP posture
- Brand and distribution

AI affects every one of those. But the CEO's strategic terrain is not *only* AI. If we hide the broader analysis inside the AI section, we (a) make the AI analysis incoherent because it has to keep apologizing for the rest of the business, and (b) starve the report of the structured non-AI read the CEO actually needs.

So: SWOT is the structured read of the whole strategic terrain. AI is one cross-cut, declared explicitly in every quadrant.

---

## Quadrant structure

Every quadrant has **3–6 points** (more for grand, fewer for short). Every point is tagged with the lens it comes from:

- `[industry]` — industry structure, market trajectory, sector dynamics
- `[stage/financials]` — runway, burn, growth rate, profitability, unit economics, capital structure
- `[constraints]` — partnerships, contracts, agreements, regulatory posture, geographic regulation, debt, vendor lock-in
- `[talent]` — team depth, key-person risk, hiring pipeline, scarce roles
- `[technology]` — technical IP, stack, data assets, platform dependencies
- `[brand/distribution]` — channel, brand, customer acquisition motion, network effects
- `[AI cross-cut]` — how AI specifically amplifies, erodes, opens, or attacks this point

**At least one `[AI cross-cut]` point is required per quadrant.** AI is always a force on every part of a business; pretending otherwise is the failure mode.

Every point must:

1. Be specific enough to fail the "could apply to any peer" test. If it could be lifted verbatim into a competitor's SWOT, cut it.
2. Cite evidence (brain entity page, doc, primary source) or be flagged as `Synthesis:`.
3. Tie back to the company's circumstance — not abstract industry musings.

---

## Per-horizon scoping

The lenses emphasized and the time window of the SWOT shift by horizon.

| Horizon | Time window | Quadrant depth | Lens emphasis |
|---|---|---|---|
| **short** | 0–12 months | 3 per quadrant | `[stage/financials]`, `[constraints]`, `[talent]`, `[AI cross-cut]` |
| **medium** | 12–36 months | 4 per quadrant | `[industry]`, `[talent]`, `[technology]`, `[brand/distribution]`, `[AI cross-cut]` |
| **long** | 3–5 years | 5 per quadrant | `[industry]` reshape, `[technology]` S-curves, `[constraints]` regulatory, `[AI cross-cut]` heavy |
| **grand** | 10–20+ years | 5–6 per quadrant | `[industry]` existence questions, `[constraints]` civilizational, `[AI cross-cut]` as restructuring force |

Lens emphasis is a *floor*, not a ceiling. Any lens may appear at any horizon if it is load-bearing.

---

## Forcing questions per quadrant

Use these to push past generic bullets.

**Strengths**

- What can we do that a well-funded competitor entering tomorrow could not replicate in 18 months?
- What is durable about our position that is *not* on the homepage? (Internal compounding, data, relationships, regulatory standing.)
- Where does our cost structure or pricing have headroom because of an asset we own?
- `[AI cross-cut]` Which existing assets *appreciate* in an AI-native world (proprietary data, regulated workflows, trust relationships, deterministic engines, hard-to-fake compliance posture)?

**Weaknesses**

- Which line items in the P&L are larger than they should be at our stage?
- Which agreements / partnerships / customer concentration would hurt most if renegotiated tomorrow?
- Where are we one departure away from a capability gap?
- Where is the gap between what customers say they want and what we ship?
- `[AI cross-cut]` Which parts of our cost stack, moat, or product surface *depreciate* as AI commoditizes the underlying capability?

**Opportunities**

- What adjacent market are we 80% of the way to entering and don't realize it?
- What pricing change does the market reality already support that we haven't taken?
- Which customer segment is structurally underserved by our largest competitor in a way we could exploit?
- `[AI cross-cut]` What product, distribution motion, cost structure, or customer base *becomes possible* if AI cognition is functionally free in the horizon's window? What can we build that was previously uneconomic?

**Threats**

- Which competitor would hurt most if they shipped tomorrow what they're hiring for today?
- Which regulatory direction in our jurisdictions is moving against us?
- Which customer dependency, vendor dependency, or platform dependency could cut against us inside the horizon?
- Which civilizational or macroeconomic shift (demographics, energy, interest rates, geopolitics) bends our market against us?
- `[AI cross-cut]` Which AI-native entrant (or AI-retooled incumbent) could collapse our differentiation? On what timeline? What would their P&L look like vs ours?

---

## Subagent prompt template

> You are researching the SWOT slice of a chief-of-staff report.
>
> **Company:** <name + one-sentence mission from profile.md>
> **Industry:** <from profile.md>
> **Stage / financial posture:** <from profile.md and most recent financials ingest>
> **Known constraints:** <partnerships, agreements, regulatory posture, key contracts — from profile.md and entity pages>
> **Horizon:** <short / medium / long / grand>
> **Time window:** <0–12 mo / 12–36 mo / 3–5 yr / 10–20+ yr>
> **Depth target:** <3 / 4 / 5 / 5–6> points per quadrant
> **Lens emphasis:** <horizon-specific list>
> **CEO focus areas:** <from step 1>
> **Word budget:** ≤<N> words (600 short, 900 medium, 1300 long, 1800 grand)
>
> **Brain excerpt (do not re-derive — extend or overturn):**
> <relevant entity-page content for industry, competitors, partnerships, prior SWOT>
>
> For each quadrant, return the target number of points. Each point must:
>
> 1. Lead with a lens tag in square brackets: `[industry]`, `[stage/financials]`, `[constraints]`, `[talent]`, `[technology]`, `[brand/distribution]`, or `[AI cross-cut]`.
> 2. Be one tight sentence stating the strength / weakness / opportunity / threat in company-specific terms.
> 3. Be followed by one sentence of evidence or mechanism, with a citation.
> 4. Be specific enough that lifting it into a peer's SWOT verbatim would obviously not fit.
>
> Required: **at least one `[AI cross-cut]` point per quadrant.**
>
> Anti-patterns to refuse:
> - "Strong team" / "Growing market" / "Increased competition" — generic, cut.
> - Any point that could apply to any company in the space.
> - Restating an opportunity as the absence of a threat (or vice versa).
> - Mixing horizons — a 5-year threat does not belong in a short-horizon SWOT.
> - More than one `[AI cross-cut]` becoming the whole quadrant — AI is *a* cross-cut, not *the* analysis.

---

## Where to look

- **Brain first:** `entities/themes/industry.md`, `entities/themes/competitive-landscape.md`, `entities/themes/regulatory.md`, `entities/companies/<peer>.md`, prior briefing SWOTs, prior decisions and their outcomes.
- **Internal:** `profile.md` (stage, industry, constraints), most recent financials ingest, current org chart, hiring plan, partnership agreements in Drive, customer concentration in CRM.
- **External:** industry analyst reports (Gartner, Forrester, McKinsey, BCG, sector-specific), public-company earnings transcripts in the sector, M&A activity, regulatory publications.
- **AI cross-cut:** the same primary-source AI tier the AI Leverage section uses — vendor releases, frontier-lab papers, eval suites — but framed as "which quadrant does this affect for *us*?"

---

## Output the subagent should return

Plain prose, ≤word budget, with the structure:

```
## Strengths
- [lens] <point>. <evidence + citation>.
- [lens] <point>. <evidence + citation>.
- [AI cross-cut] <point>. <evidence + citation>.
...

## Weaknesses
...

## Opportunities
...

## Threats
...
```

Plus a **deltas** block: which points are new since the last SWOT at this horizon, which carried over, which were resolved or invalidated.

The main report integrates these into the top-level **SWOT** section of [templates/report.md](../templates/report.md). The SWOT subagent's output is also a primary input to the **Decisions** section — if a SWOT point demands a decision this run, it should surface there.

---

## Calibration

Read `profile.md` before launching:

- **Company stage** (pre-seed / seed / Series A–C / late stage / public / cash-flow-positive bootstrapped) — drives which lenses dominate.
- **Industry** — drives the external research the subagent runs. Electronics, e-commerce, SaaS, real estate, manufacturing, space, biotech, financial services, defense, energy, agriculture each have different default threat / opportunity patterns and regulatory regimes.
- **Existing constraints** — partnerships, exclusivity agreements, vendor lock-in, debt covenants, geographic regulatory posture. These often dominate the `[constraints]` lens and must be loaded explicitly.
- **Profitability and growth posture** — a profitable bootstrapped company at 15% growth has a different threat profile than a venture-backed company at 200% growth burning $4M/mo. The SWOT framing must reflect that.
- **Competitive intensity** — fragmented commodity market vs concentrated oligopoly vs greenfield.

---

## Anti-patterns

- A generic SWOT that could apply to any peer. Every point must be specific to *this* company.
- AI bullets segregated into a single quadrant ("AI Threats") rather than woven across all four.
- Treating SWOT as a list dump instead of feeding Decisions. If nothing in SWOT shows up in Decisions or Risks, the SWOT is decorative.
- Symmetric framing — every strength has an inverse weakness, every opportunity an inverse threat. Strategic reality is asymmetric; SWOT should reflect that.
- Carrying forward last quarter's SWOT unchanged. Each run extends, overturns, or retires prior points.
- Quantifying everything to false precision. Direction and mechanism beat made-up percentages.
