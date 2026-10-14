# Chief of Staff

Two Claude Code skills that give a CEO a chief of staff with a persistent memory:

- **`chief-of-staff-review`**: produces strategic briefings across four horizons (short, medium, long, grand vision).
- **`chief-of-staff-curate`**: runs on a schedule between briefings and folds new data, feedback, and decision outcomes into the brain.

Both read and write a markdown "brain" at `~/.claude/chief-of-staff/`.

## Install

Symlink both skill directories into your skills folder:

```bash
ln -s "$PWD/chief-of-staff-review" ~/.claude/skills/chief-of-staff-review
ln -s "$PWD/chief-of-staff-curate" ~/.claude/skills/chief-of-staff-curate
```

Optional: install `sqlite3` to get FTS5 search over the brain. Without it, search falls back to ripgrep.

## Setup

1. **Run your first briefing.** Ask Claude: *"Give me a chief of staff review."* On the first run the skill creates the brain and walks you through a profile.
2. **Schedule the curator.** Don't skip this step. Without the curator, every briefing rebuilds context from scratch.
   > Schedule chief-of-staff-curate daily at 04:00.

   You can use cron instead: `0 4 * * * claude -p "/chief-of-staff-curate"`
3. **Schedule ingest (optional, recommended).** Daily or weekly digests of Gmail, Calendar, Slack, GitHub, financials, and external news go into `ingest/<source>/`. See [sources/ingest.md](chief-of-staff-review/sources/ingest.md) for the job contracts.
4. **Connect data sources** through MCP (Google Workspace, Slack, Stripe/QuickBooks, CRM, Linear) and the `gh` CLI. Missing sources won't break anything. Each briefing's *What I couldn't see* section lists the gaps.

## Usage

| I want to… | Say / do |
|---|---|
| Get a briefing | *"Brief me"* or *"chief of staff review"* |
| Pick a horizon | *"Short / medium / long / grand-vision review"* |
| Focus or skip a topic | *"…focus on fundraising"*, *"…skip hiring"* |
| Log a decision | *"Based on this, I'm deciding X"*. Later briefings follow up on it. |
| Improve future briefings | Answer the three feedback questions asked after each briefing |
| Refresh the brain manually | *"cos curate"* |
| Search the brain | `chief-of-staff-review/scripts/brain-search.sh "query" [--project <slug>] [--kind company]` |
| Correct what it "knows" | Edit the markdown in `~/.claude/chief-of-staff/` directly |
| Reset | `rm -rf ~/.claude/chief-of-staff/` |

Approximate run times: short ~10 min, medium ~15–20 min, long ~25–30 min, grand vision ~45–60 min.

## Brain layout

```
~/.claude/chief-of-staff/
├── operator/            # facts about you, shared across projects (ceo-patterns.md, profile, personas)
└── projects/<slug>/     # one per company: profile, entities/, ingest/, briefings/, feedback/, curator/
```

The skill picks the project from your current directory, using `operator/projects.json`. Each entity page has a rewritable "compiled truth" section, then an append-only timeline after a `---` line.

To migrate an older single-project brain, run `chief-of-staff-review/scripts/migrate-to-projects.sh --slug <slug>`. This is a dry run. Add `--execute` to apply it.

## Repo layout

```
chief-of-staff-review/
  SKILL.md        # briefing orchestration
  horizons/       # per-horizon playbooks
  sources/        # per-source playbooks, synthesis rules, ingest contracts
  templates/      # briefing and entity-page formats
  scripts/        # index.sh, brain-search.sh, migrate-to-projects.sh
  README.md       # full user guide
chief-of-staff-curate/
  SKILL.md        # between-briefing consolidation
```

For the full guide, including how to read a briefing, how to give feedback, and troubleshooting, see [chief-of-staff-review/README.md](chief-of-staff-review/README.md).
