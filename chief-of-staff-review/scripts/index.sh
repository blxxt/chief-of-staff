#!/usr/bin/env bash
# Build / refresh an FTS5 index over the chief-of-staff brain.
#
# Usage:
#   scripts/index.sh                    # rebuild full index
#   scripts/index.sh path/to/file.md    # incremental update for one file
#
# Indexes both operator/ and projects/<slug>/ subtrees, tagging each doc with its
# project ("operator" for the shared layer, "<slug>" for per-project files).
#
# Idempotent. Safe to re-run.

set -euo pipefail

BRAIN_DIR="${COS_BRAIN_DIR:-$HOME/.claude/chief-of-staff}"
DB="$BRAIN_DIR/.index.sqlite"

if [ ! -d "$BRAIN_DIR" ]; then
  echo "Brain dir not found: $BRAIN_DIR" >&2
  exit 1
fi

if ! command -v sqlite3 >/dev/null 2>&1; then
  echo "sqlite3 not installed — skipping FTS5 index. Briefing will fall back to ripgrep." >&2
  exit 0
fi

# Bootstrap schema. Note: schema includes `project` column (operator|<slug>).
# Drop legacy schema on first run if it lacks `project`.
if [ -f "$DB" ] && ! sqlite3 "$DB" "SELECT project FROM docs LIMIT 1" >/dev/null 2>&1; then
  echo "Legacy schema detected — dropping and rebuilding index."
  rm -f "$DB"
fi

sqlite3 "$DB" <<'SQL'
CREATE TABLE IF NOT EXISTS docs (
  path TEXT PRIMARY KEY,
  mtime INTEGER NOT NULL,
  project TEXT NOT NULL,
  kind TEXT NOT NULL,
  slug TEXT,
  body TEXT NOT NULL
);
CREATE VIRTUAL TABLE IF NOT EXISTS docs_fts USING fts5(
  path, project, kind, slug, body,
  content='docs', content_rowid='rowid',
  tokenize='porter unicode61'
);
CREATE TRIGGER IF NOT EXISTS docs_ai AFTER INSERT ON docs BEGIN
  INSERT INTO docs_fts(rowid, path, project, kind, slug, body) VALUES (new.rowid, new.path, new.project, new.kind, new.slug, new.body);
END;
CREATE TRIGGER IF NOT EXISTS docs_ad AFTER DELETE ON docs BEGIN
  INSERT INTO docs_fts(docs_fts, rowid, path, project, kind, slug, body) VALUES('delete', old.rowid, old.path, old.project, old.kind, old.slug, old.body);
END;
CREATE TRIGGER IF NOT EXISTS docs_au AFTER UPDATE ON docs BEGIN
  INSERT INTO docs_fts(docs_fts, rowid, path, project, kind, slug, body) VALUES('delete', old.rowid, old.path, old.project, old.kind, old.slug, old.body);
  INSERT INTO docs_fts(rowid, path, project, kind, slug, body) VALUES (new.rowid, new.path, new.project, new.kind, new.slug, new.body);
END;
SQL

classify() {
  # Set globals KIND and PROJECT from a path relative to BRAIN_DIR.
  local rel="$1"
  case "$rel" in
    operator/operator-profile.md)  PROJECT="operator"; KIND="operator-profile" ;;
    operator/ceo-patterns.md)      PROJECT="operator"; KIND="ceo-patterns" ;;
    operator/recurring-themes.md)  PROJECT="operator"; KIND="themes-index" ;;
    operator/personas.md)          PROJECT="operator"; KIND="personas" ;;
    operator/projects.json)        PROJECT="operator"; KIND="projects-map" ;;
    operator/*)                    PROJECT="operator"; KIND="operator-other" ;;
    projects/*)
      PROJECT="${rel#projects/}"
      PROJECT="${PROJECT%%/*}"
      local sub="${rel#projects/$PROJECT/}"
      case "$sub" in
        profile.md)             KIND="profile" ;;
        index.md)               KIND="briefings-index" ;;
        entities/people/*)      KIND="person" ;;
        entities/companies/*)   KIND="company" ;;
        entities/themes/*)      KIND="theme" ;;
        entities/decisions/*)   KIND="decision" ;;
        briefings/*)            KIND="briefing" ;;
        ingest/*)               KIND="ingest" ;;
        feedback/*)             KIND="feedback" ;;
        curator/*)              KIND="curator" ;;
        *)                      KIND="other" ;;
      esac
      ;;
    *)
      # Legacy / unmigrated content at brain root — index it as legacy/unscoped.
      PROJECT="legacy"
      case "$rel" in
        profile.md)            KIND="profile" ;;
        ceo-patterns.md)       KIND="ceo-patterns" ;;
        recurring-themes.md)   KIND="themes-index" ;;
        entities/people/*)     KIND="person" ;;
        entities/companies/*)  KIND="company" ;;
        entities/themes/*)     KIND="theme" ;;
        entities/decisions/*)  KIND="decision" ;;
        briefings/*)           KIND="briefing" ;;
        ingest/*)              KIND="ingest" ;;
        feedback/*)            KIND="feedback" ;;
        curator/*)             KIND="curator" ;;
        *)                     KIND="other" ;;
      esac
      ;;
  esac
}

sql_quote() {
  printf "%s" "$1" | sed "s/'/''/g"
}

upsert_file() {
  local abs="$1"
  local rel="${abs#"$BRAIN_DIR"/}"
  [ "${rel%.md}" != "$rel" ] || return 0   # only index .md
  local mtime PROJECT KIND slug body
  mtime=$(stat -f %m "$abs" 2>/dev/null || stat -c %Y "$abs" 2>/dev/null || echo 0)
  classify "$rel"
  slug=$(basename "$rel" .md)
  body=$(<"$abs")

  sqlite3 "$DB" <<SQL
INSERT INTO docs(path, mtime, project, kind, slug, body)
VALUES ('$(sql_quote "$rel")', $mtime, '$(sql_quote "$PROJECT")', '$(sql_quote "$KIND")', '$(sql_quote "$slug")', '$(sql_quote "$body")')
ON CONFLICT(path) DO UPDATE SET
  mtime=excluded.mtime,
  project=excluded.project,
  kind=excluded.kind,
  slug=excluded.slug,
  body=excluded.body
WHERE docs.mtime < excluded.mtime;
SQL
}

if [ $# -ge 1 ]; then
  for f in "$@"; do
    [ -f "$f" ] && upsert_file "$f"
  done
else
  while IFS= read -r -d '' f; do
    upsert_file "$f"
  done < <(find "$BRAIN_DIR" -type f -name '*.md' -not -path "$BRAIN_DIR/.index.sqlite*" -print0)
fi

sqlite3 "$DB" "INSERT INTO docs_fts(docs_fts) VALUES('optimize');" 2>/dev/null || true

count=$(sqlite3 "$DB" "SELECT COUNT(*) FROM docs;")
echo "Indexed $count documents into $DB"
