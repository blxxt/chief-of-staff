#!/usr/bin/env bash
# Search the chief-of-staff brain via FTS5.
#
# Usage:
#   scripts/brain-search.sh "hiring pipeline"
#   scripts/brain-search.sh "competitor" --kind company --limit 5
#   scripts/brain-search.sh "regulatory" --project acme
#   scripts/brain-search.sh "blind spot" --project operator   # operator-scope only
#
# Falls back to ripgrep if .index.sqlite does not exist.
# Searches across operator/ and all projects/<slug>/ unless --project is given.

set -euo pipefail

BRAIN_DIR="${COS_BRAIN_DIR:-$HOME/.claude/chief-of-staff}"
DB="$BRAIN_DIR/.index.sqlite"

QUERY=""
KIND=""
PROJECT=""
LIMIT=10

while [ $# -gt 0 ]; do
  case "$1" in
    --kind)    KIND="$2"; shift 2 ;;
    --project) PROJECT="$2"; shift 2 ;;
    --limit)   LIMIT="$2"; shift 2 ;;
    *)         QUERY="${QUERY:+$QUERY }$1"; shift ;;
  esac
done

if [ -z "$QUERY" ]; then
  echo "Usage: $0 <query> [--kind person|company|theme|decision|briefing|ingest] [--project <slug>|operator] [--limit N]" >&2
  exit 1
fi

if [ ! -f "$DB" ] || ! command -v sqlite3 >/dev/null 2>&1; then
  # Fallback to ripgrep. Scope to project subtree if requested.
  SEARCH_DIR="$BRAIN_DIR"
  if [ -n "$PROJECT" ]; then
    if [ "$PROJECT" = "operator" ]; then
      SEARCH_DIR="$BRAIN_DIR/operator"
    else
      SEARCH_DIR="$BRAIN_DIR/projects/$PROJECT"
    fi
  fi
  if command -v rg >/dev/null 2>&1; then
    rg --type md --max-count 5 -i "$QUERY" "$SEARCH_DIR"
  else
    grep -rni --include='*.md' -l "$QUERY" "$SEARCH_DIR"
  fi
  exit 0
fi

# FTS5 search with optional filters.
ESC_QUERY="${QUERY//\'/\'\'}"
WHERE="docs_fts MATCH '$ESC_QUERY'"
[ -n "$KIND" ]    && WHERE="$WHERE AND kind = '$KIND'"
[ -n "$PROJECT" ] && WHERE="$WHERE AND project = '$PROJECT'"

sqlite3 "$DB" -separator $'\t' \
  "SELECT path, project, kind, slug, snippet(docs_fts, 4, '[', ']', '…', 12) AS snip
   FROM docs_fts
   WHERE $WHERE
   ORDER BY bm25(docs_fts)
   LIMIT $LIMIT;"
