# Sources: AI Leverage

How to research what AI means for *this* company at the current horizon. AI is moving faster than the rest of the report's inputs, so it gets its own playbook — different mode per horizon, stricter recency rules, and an explicit anti-hype bar.

This file is referenced by every horizon. **Always spawn at least one AI leverage subagent per run, even if the ingest digest is fresh** — AI capabilities shift faster than the digest cadence, so this is the one source where the brain-first rule is deliberately relaxed. Mode (adoption / frontier / restructure) is set by the horizon.

The subagent should still receive the most recent AI-related entity pages and the most recent AI-leverage findings from prior briefings as `What I already know (do not re-derive)`, so it focuses on **what shifted in the last 1–4 weeks**, not on restating known frontier capabilities.

---

## The leverage thesis (load-bearing)

AI is not a tool to apply to existing workflows. It is a force that will restructure how companies, products, industries, supply chains, partnerships, governments, and customer bases function. To navigate the transition well, a CEO must critically question every aspect of their business and every assumption about their industry against what AI will increasingly provide in capability and efficiency.

Most CEOs will apply AI to existing workflows and strategies and yield modest improvements. The CEOs who disproportionately compound alongside AI's growth will act decisively to restructure their company, products, services, partnerships, vision, and strategy into an AI-first organization. **This is the failure mode this section exists to prevent: a CEO who keeps up with their industry but not with AI, and ships a competently AI-augmented version of the company that should not exist in five years.**

The job of this section is to force three distinct questions, in this order:

1. **Adopt:** what AI capability shipping today is this company under-using?
2. **Bet:** what frontier capability is on a rising S-curve that will reshape our strategic terrain inside the horizon's window?
3. **Restructure:** if we re-founded this company today, AI-native from scratch, knowing what we now know about where capability and cost are headed — what would we *not* be doing that we are doing, and what would we be doing that we are not?

Question 3 is the one most CEOs skip because it threatens sunk cost, headcount shape, partnerships, and identity. It is also the one most likely to produce the disproportionate-value decisions this whole skill exists to surface. The subagent must produce it; the synthesizer must feed it into Decisions, not bury it in this section.

The SWOT analysis that *includes* AI as a cross-cutting lens lives in its own section — see [swot.md](swot.md). That section reads AI as one of several forces on the company. This section reads AI as the primary force and asks the restructuring question head-on.

---

## Three modes

Pick the mode(s) by horizon:

- **Adoption** — short, medium
- **Frontier** — medium, long, grand
- **Restructure** — medium, long, grand (mandatory at long and grand; recommended at medium)

### Adoption mode (short, medium)

**Question:** what AI capability that **exists in production today** is this company under-using?

Frame findings as concrete adoptions the CEO could green-light this quarter:

- **Workflow / ops:** which recurring CEO time-sinks, support escalations, or back-office workflows can be 80%-replaced by current Claude / GPT / Gemini / Codex / Copilot tooling?
- **Product features:** what AI-native feature is now table-stakes in our category that we lack? What is a competitor shipping that we should have shipped?
- **Cost structure:** where in the cost stack does AI swap human labor or expensive software for sub-dollar inference? Where could gross margin improve materially in 2–4 quarters?
- **Internal velocity:** dev tooling, design tooling, sales enablement, recruiting funnels — anywhere a 10–50% velocity gain is achievable with current commercial tools, not lab demos.

**Bar for inclusion:** the capability must be production-ready *today* (commodity API, GA product, or a model already deployed by ≥3 named peers). If it's lab-only, it belongs in frontier mode.

### Frontier mode (medium, long, grand vision)

**Question:** what AI capability is on the rising edge of an S-curve that will change this company's strategic terrain inside the horizon's window?

Frame findings as bets to start *now* because the lead time is the horizon:

- **Capability trajectories:** open-source LLM parity with frontier closed models, long-context memory, agentic systems, multimodal/video, code generation, voice, on-device inference. Where is the S-curve, and when does it commoditize?
- **Nth-order tech AI is accelerating:** world models → physics / electromagnetics / chemistry / biology simulation at fractions of current cost; cheap inference → self-hosting / local-first architectures; robotics foundation models → physical-world automation; protein/materials models → R&D cycle compression. Pick the 1–3 that are load-bearing for *this* company.
- **Cost curves:** inference $/token has dropped ~10× twice in 24 months. What becomes possible at another 10× drop? At 100×?
- **Regulatory direction:** EU AI Act tiers, US executive-order trajectory, sectoral rules (FDA on AI-as-medical-device, financial AI disclosures). What opens or closes for us in the horizon's window?
- **Competitive shape:** who is the AI-native competitor we don't take seriously today that compounds faster than us in 24–60 months?

**Bar for inclusion:** every frontier claim cites a primary source (paper, model card, eval result, vendor release, regulator publication). Distinguish:

- **Commodity** — already an API or open weight
- **Production-ready** — demonstrated in shipping products, not just demos
- **Lab-only** — paper or research demo, not yet in a shipped product
- **Speculative** — extrapolation from trends; explicitly flagged

Lab-only and speculative claims may be included but cap the dependent recommendation at low confidence (see [synthesis.md](synthesis.md)).

### Restructure mode (medium, long, grand)

**Question:** if we re-founded this company today, AI-native, from scratch — knowing where capability and cost are headed in the horizon's window — what would the company look like, and what is the *delta* from the current company?

This is the most important mode and the easiest one to fumble. The failure mode is producing a tidy list of "ways we could use AI more." That is adoption mode. Restructure mode is harder: it asks the CEO to consider that the business shape, headcount mix, product surface, pricing, partnerships, and even the *reason for existing* may be wrong assumptions inherited from a pre-AI world.

Forcing questions (the subagent must engage every one of these explicitly, not skip past them):

- **Cost stack collapse.** If frontier-grade AI cognition costs near-zero in 24 months ([Epoch AI inference price trends](https://epoch.ai/data-insights/llm-inference-price-trends)), which of our line items collapses? Which of our prices? Which of our pricing pages becomes unsustainable?
- **Org shape.** Which roles, teams, or layers exist because pre-AI workflows required them, and would not be hired today? Which roles would we hire today that we have zero of?
- **Product surface.** Which features exist because the user could not previously do them themselves? Which products would not exist if we were re-founded today? What is the AI-native version of our core product surface?
- **Partnerships and agreements.** Which of our partnerships, distribution deals, vendor contracts, or customer agreements were structured pre-AI and would be renegotiated — or refused — today? Which give away leverage we would not give away if we were starting over?
- **Customers going AI-native.** What happens to our product when our customer base goes AI-native? If our customers have agents that can integrate, negotiate, switch, compare, or build alternatives — does our product still make sense? Does our pricing? Does our moat?
- **Distribution motion.** Pre-AI distribution assumed humans clicking. AI-native distribution assumes agents calling APIs / MCP servers / structured endpoints. Which of our distribution channels evaporates, and which new ones must we be present in?
- **Competitor founded yesterday.** What would an AI-native competitor founded six months ago, well-funded, with no legacy obligations, do that we will not do because of inertia, sunk cost, identity, or headcount shape? Name the company that does not yet exist.
- **Refuse to do.** AI-first restructuring is not only addition; it is subtraction. What should we stop building, stop selling, stop charging for, stop hiring against — *now* — because the AI-native version of this company would not have it?

**Bar for inclusion:** every restructure point must (a) name the specific assumption that would change, (b) name the current state of the company that depends on that assumption, and (c) propose what changes if the assumption is wrong. Vague "we should think about how AI changes our industry" does not survive review.

**Coupling to Decisions.** Restructure findings are the most likely to surface as foundational decisions. The synthesizer must promote at least one restructure finding into Decisions if any survive the bar — not bury all of them in this section. See [synthesis.md](synthesis.md).

---

## Subagent prompt template

> You are researching the AI leverage slice of a chief-of-staff report.
>
> **Company:** <name + one-sentence mission from profile.md>
> **Industry / stage / constraints (from profile.md):** <brief>
> **Horizon:** <short / medium / long / grand vision>
> **Modes to produce:** <adoption / frontier / restructure — one or more>
> **Current AI posture (from profile.md):** <AI-native / AI-adopting / AI-skeptical / AI-regulated>
> **CEO focus areas:** <from step 1>
> **Word budget:** ≤<N> words (500 short, 900 medium, 1300 long, 1800 grand)
>
> Return findings tied to *this* company's specific situation, separated by mode.
>
> **For adoption / frontier findings**, each finding states:
>
> 1. The AI capability (with a primary-source citation: paper, model card, eval, vendor release URL).
> 2. Readiness tier: commodity / production-ready / lab-only / speculative.
> 3. Implication for *this* company at *this* horizon (not the industry generically).
> 4. What it would take to act (resources, time, who).
>
> **For restructure findings**, each finding states:
>
> 1. The pre-AI assumption baked into the current company (in one sentence).
> 2. The specific current state of the company that depends on that assumption (org line, product line, partnership, pricing, etc., with citation to the brain or doc that confirms it).
> 3. What changes — concretely — if the assumption is wrong, on the horizon's time window.
> 4. The AI-capability premise the assumption-shift depends on (with readiness tier and citation).
> 5. A one-sentence sketch of the AI-native counterfactual ("an AI-native competitor founded today would …").
>
> The restructure section must produce at least 3 findings at medium, 5 at long, 6 at grand. If fewer survive the bar, say so and explain why — do not pad.
>
> Recency rule: any capability claim older than 6 months must be re-verified against a current source or dropped. AI moves fast enough that stale citations mislead more than they help.
>
> Anti-hype rules:
> - No Twitter takes as primary sources.
> - No "AI will revolutionize X" claims without a specific mechanism.
> - Do not conflate demo with production.
> - If a recommendation depends on a capability that doesn't exist yet, say so explicitly.
> - Restructure findings must name the specific pre-AI assumption, not gesture at "AI changes everything."

---

## Where to look

**For adoption mode:**
- Vendor changelogs and model cards: Anthropic, OpenAI, Google DeepMind, Mistral, Meta AI, xAI, Cohere
- Open-source release pages: Hugging Face trending, Llama / Qwen / DeepSeek / Mixtral model cards
- Competitor product pages and changelogs — what AI features are they shipping?
- Internal signal: shadow-AI usage already happening in Slack / Gmail / Drive (people pasting Claude outputs, sharing prompts) — the team is voting with their workflow
- Tooling-category leaders: Cursor / Claude Code / GitHub Copilot for eng; Granola / Fireflies for ops; Clay / Apollo for sales; etc.

**For frontier mode:**
- arXiv (cs.LG, cs.CL, cs.AI), Papers with Code, OpenReview
- Frontier lab research pages and technical reports (Anthropic, OpenAI, DeepMind, FAIR, Microsoft Research)
- Capability eval suites: METR, HELM, SWE-bench, LiveBench, ARC-AGI, GPQA
- Forecasts: Epoch AI scaling analyses, Metaculus / Manifold / Polymarket on AI milestones
- Regulators: EU AI Act publications, US AISI, NIST AI RMF, sector-specific (FDA, FCC, SEC)
- Capital signal: a16z, Sequoia, USV, Stratechery, Ben Thompson, Latent Space, Interconnects — link the public post, do not paraphrase paywalled content

---

## Output the subagent should return

Plain prose, ≤word budget, with the structure:

1. **Adoption findings** (if adoption mode): bulleted list, each finding = capability + readiness + company-specific implication + cost-of-delay.
2. **Frontier findings** (if frontier mode): bulleted list, each finding = capability + S-curve position + commoditization estimate + company-specific implication.
3. **Restructure findings** (if restructure mode): bulleted list, each finding = pre-AI assumption + current dependent state + counterfactual + AI-capability premise + AI-native competitor sketch.
4. **Capability claims that need watching:** 2–5 specific signals (e.g. "GPT-5 release", "open-source 4B-param model matches Claude Sonnet on SWE-bench", "EU AI Act enforcement actions begin") whose firing should retrigger this section.

The main report integrates these into the "AI Leverage" section of [templates/report.md](../templates/report.md). The **restructure findings** in particular are designed to flow into the **Decisions** section of the briefing, not to sit ornamentally in AI Leverage — see [synthesis.md](synthesis.md).

The SWOT analysis is **not** produced by this subagent. It lives in [swot.md](swot.md) and is run as a separate subagent.

---

## Calibration

Read `profile.md` before launching the AI leverage subagent. Calibrate by:

- **AI-native company** → skip adoption basics; lead with frontier and restructure (the AI-native company most needs the "are we still AI-native?" challenge, because the bar moves every quarter).
- **AI-adopting company** → balance adoption and frontier; require a restructure section at medium+ — this is the company most at risk of "competently augmented but strategically obsolete."
- **AI-skeptical company** → lead with concrete adoption wins, ROI-quantified; do *not* soften the restructure section — the skeptical CEO needs to hear it precisely because they will not produce it themselves.
- **AI-regulated company** (HIPAA, FedRAMP, EU AI Act high-risk, etc.) → every recommendation gates on regulatory posture; restructure findings must include the regulatory delta of the AI-native counterfactual.
- **CEO AI fluency self-rating low** → explain capabilities in domain-analogue terms, not LLM jargon.
- **CEO AI fluency self-rating high** → skip explainers; go straight to implication and recommendation.

---

## Anti-patterns

- A generic AI trends list. Every claim must connect to this company.
- "AI will transform the industry" — state the mechanism or cut it.
- Recommending lab-only capability as if it were production-ready.
- Repeating a frontier claim across reports without re-verifying it. Capability moves; the report should move with it.
- Hyping a model release that doesn't change what this company can do.
- Conflating *AI strategy* with *AI tooling adoption*. Both belong, but distinguish them.
- **Treating restructure mode as a louder version of adoption mode.** Restructure is about what to *stop*, *redesign*, or *refuse* — not a longer list of things to adopt.
- Producing restructure findings that are too comfortable. If every restructure finding is something the CEO would already nod along to, the bar is too low.
- Letting the SWOT analysis bleed into this section. SWOT is its own section; AI is only one cross-cut of it. This section is the place to make the restructuring case.
