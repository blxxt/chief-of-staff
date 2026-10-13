# Customer Voice

**Always re-run per briefing.** The single most consistent failure mode of founder CEOs is losing touch with customer reality — Lenny Rachitsky's most-repeated guest advice across 200+ episodes is "talk to 5 users a week." This source exists to make that the default, not the exception.

Customer voice is not the CRM. The CRM is a sales pipeline view. This is the *verbatim* signal: what customers actually said, in their own words, in the last 7 days.

---

## What this source surfaces

Every briefing receives:

1. **Top 3 support escalations** from last 7 days — by frequency, by severity, by named-account weight. Verbatim ticket text, not paraphrase.
2. **Churn reasons** from accounts cancelled in last 30 days. Verbatim exit-interview text. If no exit interview, flag the gap.
3. **Win/loss highlights** from last 30 days. The reason given by the prospect, not the rep's reframe. Especially the *losses*.
4. **NPS verbatims** — not the score. The free-text comments from last 30 days, clustered.
5. **Sales call objections** — most recent 3 calls' verbatim objections. The sentence the prospect actually said, not the rep's summary.
6. **Shadow signals** — power-user community posts, support chat patterns, Slack/Discord community moves, customer-written tweets/posts about us in last 30 days.

---

## The one mandatory output

**Nominate one specific customer for the CEO to call this week.** Name + role + company + one-line topic. Why this customer, why this week.

This is the most CoS-ish thing the source can do. If the CEO calls one customer a week for a year, the company will be in the top decile of customer-attuned companies. The skill makes that easy.

Selection criteria (in order):

1. **Quietly cancelled or about-to-cancel mid-tier customer** — the silent churn signal CEOs miss because it's not loud enough for a save desk.
2. **A specific complaint that recurs across 3+ tickets** — surface the pattern *and* the human who can speak to it.
3. **A power user who pushed back on a recent decision** — pricing change, deprecation, sunset.
4. **A prospect who said no for a reason that contradicts our positioning** — strategic signal disguised as a lost deal.
5. **The biggest customer whose CSM didn't get a reply in 14+ days** — leading indicator of churn.

---

## Subagent prompt template

```
You are a customer-voice subagent for a chief-of-staff briefing.

Inputs to walk:
- ~/.claude/chief-of-staff/projects/<P>/ingest/customer-voice/<latest>.md (pre-digested)
- Recent support tickets (provider per profile.md — Intercom, Zendesk, HubSpot, etc.)
- Recent win/loss notes (CRM)
- Recent NPS responses (provider per profile.md)
- Recent sales call transcripts / summaries
- Community signal (Discord, Slack, GitHub Discussions, X)

For each finding, return the grammar-constrained block from sources/synthesis.md including `strongest_counter`.

Mandatory: nominate exactly one customer for the CEO to call this week.
Return shape:
  customer_to_call:
    name: "<full name>"
    role: "<title>"
    company: "<company>"
    topic: "<one-line topic, what to ask>"
    why_this_week: "<one sentence — the signal that made this the call>"

Anti-noise: do not include NPS scores without verbatims. Do not include support ticket *counts* without representative quotes. Do not nominate the CEO's existing favorite customer.
```

---

## Freshness target

- **Short horizon:** ≤7 days. Stale data here is unacceptable.
- **Medium horizon:** ≤30 days for trend analysis; latest verbatims still ≤7 days.
- **Long / grand:** trend analysis only; latest verbatims still surfaced for grounding.

If the source is not configured at first run, this is the *first* thing to flag to the CEO in **What I couldn't see** with a specific recommendation: name a tool (Gong / Chorus / Grain for calls; the CRM for win/loss; the support platform for tickets) and the access the briefing skill would need.

---

## Anti-noise rules

1. **Verbatims, not paraphrase.** "Customer said pricing is high" is noise. "Customer said: 'We can't justify $X/seat when [competitor] is $Y/seat and the migration is two weeks'" is signal.
2. **One customer name per briefing.** If you list five customers to call, the CEO calls zero.
3. **No NPS scores without verbatims.** A score with no text is a vanity metric.
4. **Surface the *quiet* signal.** The loudest customer is rarely the most strategically important. Look for the mid-tier customer with declining usage and no escalation.
5. **Track the CEO's call-throughs.** The curator should note in `ceo-patterns.md` if the CEO routinely ignores customer-call nominations — that itself is a pattern to surface.
