# Sources: External

Market, competitor, technology, and regulatory research. Always cite a **primary source** (the company's own page, the SEC filing, the research paper) rather than a secondary aggregator when possible.

---

## Subagent discipline

Same as internal sources — delegate to Haiku, request the grammar-constrained `findings` block from [synthesis.md](synthesis.md) plus ≤500–1500 words of commentary, with inline citations. Never dump raw search results into the main context.

**Read the external ingest digest first** (`~/.claude/chief-of-staff/projects/<P>/ingest/external/YYYY-MM-DD.md`). The weekly external ingest already covers competitor changelogs, funding events, and `last30days` pulses. Fan out fresh subagents only for: (a) a named competitor not covered in the latest digest, (b) a CEO focus area that requires deeper-than-weekly cadence, (c) anything genuinely time-sensitive in the briefing window.

---

## `last30days` skill

The fastest way to take the pulse of the internet on a topic. Pulls from Reddit, X, YouTube, TikTok, Hacker News, Polymarket, GitHub, and the web.

**Use it for:**
- **Short:** "what has been said about `<competitor>` in the last 30 days", "what people are saying about `<our product / category>`"
- **Medium:** "what people are saying about `<emerging tech trend>`"
- Not useful for long / grand — 30-day window is too narrow.

**Cite:** the underlying post / article URL, not the `last30days` output.

---

## WebSearch + WebFetch

For deeper, primary-source research.

**Always reach for primary:**
- Competitor changelogs and blog (fetch `/blog`, `/changelog`)
- Competitor careers page — **strongest leading indicator of strategy** (who they hire, in what functions, in what locations)
- Public-company earnings call transcripts (company IR pages, SEC filings)
- SEC filings (10-K, 10-Q, S-1) for public competitors or recent IPOs
- Analyst pages (Gartner Magic Quadrant, Forrester Wave) — link the public summary; do not paraphrase paywalled content

**Search query patterns:**
- `"<competitor>" funding round site:techcrunch.com OR site:theinformation.com`
- `"<competitor>" careers <function>`
- `"<competitor>" CEO interview <year>`
- `<industry> outlook <year+1>`

---

## Competitive analysis playbook

For each named competitor at each horizon, gather:

**Short (last 30 days):**
- Press releases, blog posts, changelog entries
- Product launches
- Funding events
- Notable exec departures or hires

**Medium (last 90–180 days):**
- Careers page snapshot — which functions are scaling
- Pricing changes
- Public roadmap / "what's next" announcements
- Customer-side signal: are our prospects mentioning them more or less?

**Long (last 12–24 months):**
- Strategic pivots
- Capital raised and at what valuation (trajectory of investor confidence)
- Geographic / market expansion patterns
- M&A — acquisitions made or rumored

Cite every claim with the URL.

---

## Industry trajectory research (long / grand only)

- Analyst reports (Gartner, Forrester, IDC) — link, summarize, do not paraphrase paywalled content
- Substacks and analysts with strong track records (Stratechery, etc.)
- Public-company earnings transcripts — read the prepared remarks **and** the analyst Q&A; the Q&A is where strategy leaks
- Academic surveys / research papers if the space is tech-driven
- Government / regulatory roadmaps (FDA, FCC, EU AI Act, etc.)

---

## Technology trend research (long / grand only)

For each technology that could compound for or against the company:
- **Capability frontier** — what was state-of-the-art 12 months ago vs today?
- **Adoption curve** — where on the S-curve is it?
- **Commoditization timeline** — when does it become infrastructure?
- **Implication** — does it strengthen or erode our moat?

**Sources:** arXiv for research, OpenReview for capability trends, Hacker News for adoption pulse, GitHub stars / issues for developer mindshare.

---

## Quality bar

External research is where hallucination risk is highest. Rules:

1. Every external claim cites a URL.
2. If you cannot find a primary source, mark the claim **"secondhand — verify before acting."**
3. Never paraphrase a paywalled article — link and summarize the public abstract only.
4. Distinguish:
   - **Fact** — cited
   - **Analyst opinion** — cited and flagged as opinion
   - **Synthesis (Claude's)** — labeled `Synthesis:` and flagged
