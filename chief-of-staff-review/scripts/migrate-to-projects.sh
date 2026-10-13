#!/usr/bin/env bash
# Migrate a single-tenant chief-of-staff brain into the operator/projects layout.
#
# Old layout:
#   ~/.claude/chief-of-staff/
#   ├── profile.md
#   ├── ceo-patterns.md
#   ├── recurring-themes.md
#   ├── entities/, ingest/, briefings/, feedback/, curator/, index.md
#
# New layout:
#   ~/.claude/chief-of-staff/
#   ├── operator/                       # one operator, shared across projects
#   │   ├── operator-profile.md
#   │   ├── ceo-patterns.md             # accumulates across all projects
#   │   ├── recurring-themes.md         # cross-project operator patterns
#   │   ├── personas.md
#   │   └── projects.json               # cwd -> project-slug map
#   └── projects/<slug>/                # per-project
#       ├── profile.md
#       ├── entities/{people,companies,themes,decisions}/
#       ├── ingest/<source>/
#       ├── briefings/, feedback/, curator/, index.md
#
# Usage:
#   scripts/migrate-to-projects.sh                          # dry-run, slug=acme
#   scripts/migrate-to-projects.sh --slug acme              # dry-run, slug=acme
#   scripts/migrate-to-projects.sh --slug acme --execute   # actually move files
#   scripts/migrate-to-projects.sh --cwd /path/to/repo --slug acme --execute
#
# Safe to re-run. If projects/<slug> already exists, exits without touching anything.

set -euo pipefail

BRAIN_DIR="${COS_BRAIN_DIR:-$HOME/.claude/chief-of-staff}"
SLUG="acme"
EXECUTE=0
CWD=""

while [ $# -gt 0 ]; do
  case "$1" in
    --slug)    SLUG="$2"; shift 2 ;;
    --execute) EXECUTE=1; shift ;;
    --cwd)     CWD="$2"; shift 2 ;;
    -h|--help)
      sed -n '2,30p' "$0"
      exit 0 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
done

if [ ! -d "$BRAIN_DIR" ]; then
  echo "Brain dir not found: $BRAIN_DIR" >&2
  exit 1
fi

OP_DIR="$BRAIN_DIR/operator"
PROJ_DIR="$BRAIN_DIR/projects/$SLUG"

# Already migrated? Bail.
if [ -d "$OP_DIR" ] && [ -d "$PROJ_DIR" ]; then
  echo "Already migrated. Operator dir: $OP_DIR  Project dir: $PROJ_DIR"
  exit 0
fi

# Detect whether we're operating on the legacy flat layout.
LEGACY=0
[ -f "$BRAIN_DIR/profile.md" ] && LEGACY=1
[ -d "$BRAIN_DIR/briefings" ] && LEGACY=1
[ -d "$BRAIN_DIR/entities" ] && LEGACY=1

if [ "$LEGACY" -eq 0 ]; then
  echo "Brain at $BRAIN_DIR does not look like a legacy flat layout. Nothing to migrate."
  exit 0
fi

PREFIX=$([ "$EXECUTE" -eq 1 ] && echo "" || echo "[dry-run] ")

run() {
  echo "${PREFIX}$*"
  if [ "$EXECUTE" -eq 1 ]; then
    # shellcheck disable=SC2294  # eval is intentional — callers pass single command strings with brace expansion
    eval "$@"
  fi
}

echo "Migration plan:"
echo "  Brain dir: $BRAIN_DIR"
echo "  Operator dir (new): $OP_DIR"
echo "  Project slug: $SLUG"
echo "  Project dir (new): $PROJ_DIR"
[ -n "$CWD" ] && echo "  cwd to register: $CWD"
echo "  Mode: $([ "$EXECUTE" -eq 1 ] && echo EXECUTE || echo dry-run)"
echo

# 1. Create operator + project directories.
run "mkdir -p '$OP_DIR'"
run "mkdir -p '$PROJ_DIR'/{briefings,feedback,curator,entities/{people,companies,themes,decisions},ingest/{gmail,calendar,github,slack,financials,customer-voice,org-health,external}}"

# 2. Move operator-scoped files. These are about the human, not the company.
for f in ceo-patterns.md recurring-themes.md; do
  if [ -f "$BRAIN_DIR/$f" ]; then
    run "mv '$BRAIN_DIR/$f' '$OP_DIR/$f'"
  fi
done

# 3. Move project-scoped files.
for f in profile.md index.md; do
  if [ -f "$BRAIN_DIR/$f" ]; then
    run "mv '$BRAIN_DIR/$f' '$PROJ_DIR/$f'"
  fi
done

for d in briefings feedback curator ingest entities; do
  if [ -d "$BRAIN_DIR/$d" ]; then
    # Move contents, not the directory itself (project already has empty skeletons).
    if [ "$EXECUTE" -eq 1 ]; then
      # shellcheck disable=SC2046
      if [ -n "$(ls -A "$BRAIN_DIR/$d" 2>/dev/null)" ]; then
        # Use rsync-like move via cp + rm to preserve nested structure across pre-existing dirs.
        (cd "$BRAIN_DIR/$d" && find . -mindepth 1 -maxdepth 1 -print0 | xargs -0 -I{} mv {} "$PROJ_DIR/$d/")
      fi
      rmdir "$BRAIN_DIR/$d" 2>/dev/null || true
    else
      echo "${PREFIX}mv '$BRAIN_DIR/$d'/* '$PROJ_DIR/$d/'   # merge into existing skeleton"
    fi
  fi
done

# 4. Move legacy FTS5 index — it's stale post-migration. Just remove; index.sh will rebuild.
if [ -f "$BRAIN_DIR/.index.sqlite" ]; then
  run "rm '$BRAIN_DIR/.index.sqlite'"
fi

# 5. Seed operator-profile.md placeholder (only if missing).
if [ ! -f "$OP_DIR/operator-profile.md" ]; then
  if [ "$EXECUTE" -eq 1 ]; then
    cat > "$OP_DIR/operator-profile.md" <<'EOF'
# Operator Profile

The human across all projects. Per-company facts belong in `projects/<slug>/profile.md`;
this file is about *you* — your working style, how you take feedback, decisions you've
made about your own time, the patterns that show up across whatever you're building.

## Identity
- **Name:**
- **Email / handle:**
- **Active projects:** (see `projects.json` for cwd map)

## Working style
- **Decision style:** (fast / deliberate / consensus-seeking / instinct-first)
- **Feedback preference:** (blunt / diplomatic / written / verbal)
- **Time horizon you naturally default to:** (short / medium / long / grand)
- **Topics you tend to avoid:**

## Across-project patterns
(The curator promotes recurring operator-level themes from `recurring-themes.md` here as
they stabilize across 2+ projects. Initially empty.)

## Tone / voice preferences per project
(See `personas.md` for the active map. Lift any cross-project tone preferences here.)
EOF
    echo "Wrote $OP_DIR/operator-profile.md"
  else
    echo "${PREFIX}write $OP_DIR/operator-profile.md (skeleton)"
  fi
fi

# 6. Seed personas.md (project tone/voice map) if missing.
if [ ! -f "$OP_DIR/personas.md" ]; then
  if [ "$EXECUTE" -eq 1 ]; then
    cat > "$OP_DIR/personas.md" <<EOF
# Personas — Per-Project Tone & Voice

The same operator can run a serious B2B startup and a personal-side hack at the same
time. The CoS should match each.

## $SLUG
- **Tone:** (serious / personal / playful / formal)
- **What this project is to me:** (career bet / side project / learning / experiment)
- **What I want the CoS to optimize for:** (rigor / speed / fun / leverage)
- **What I want the CoS to skip:** (vanity metrics / hiring talk / etc.)

(Add a section per active project as they're registered.)
EOF
    echo "Wrote $OP_DIR/personas.md"
  else
    echo "${PREFIX}write $OP_DIR/personas.md (skeleton)"
  fi
fi

# 7. Seed projects.json (cwd -> slug map).
if [ ! -f "$OP_DIR/projects.json" ]; then
  if [ "$EXECUTE" -eq 1 ]; then
    if [ -n "$CWD" ]; then
      cat > "$OP_DIR/projects.json" <<EOF
{
  "version": 1,
  "active_slug": "$SLUG",
  "cwd_to_slug": {
    "$CWD": "$SLUG"
  }
}
EOF
    else
      cat > "$OP_DIR/projects.json" <<EOF
{
  "version": 1,
  "active_slug": "$SLUG",
  "cwd_to_slug": {}
}
EOF
    fi
    echo "Wrote $OP_DIR/projects.json"
  else
    echo "${PREFIX}write $OP_DIR/projects.json (cwd map)"
  fi
fi

echo
if [ "$EXECUTE" -eq 1 ]; then
  echo "Migration complete. Rebuild the FTS5 index with:"
  echo "  scripts/index.sh"
else
  echo "Dry-run complete. Re-run with --execute to apply."
fi
