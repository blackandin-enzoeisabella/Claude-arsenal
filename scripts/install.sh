#!/usr/bin/env bash
# Instala as skills do Claude Arsenal em ~/.claude/skills (global) ou ./.claude/skills (projeto).
# Uso:
#   bash scripts/install.sh                 # todas, global → /openreel, /dockge ...
#   bash scripts/install.sh --project       # todas, só no projeto atual
#   bash scripts/install.sh --only dockge,logdeck
#   bash scripts/install.sh --link          # symlink (atualiza com git pull)
#   bash scripts/install.sh --uninstall
#   curl -fsSL https://raw.githubusercontent.com/blackandin-enzoeisabella/claude-arsenal/main/scripts/install.sh | bash
set -euo pipefail

REPO_URL="https://github.com/blackandin-enzoeisabella/claude-arsenal.git"
TARGET="${HOME}/.claude/skills"
MODE="copy"
ONLY=""
UNINSTALL=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project) TARGET="$(pwd)/.claude/skills" ;;
    --target) TARGET="$2"; shift ;;
    --only) ONLY="$2"; shift ;;
    --link) MODE="link" ;;
    --uninstall) UNINSTALL=1 ;;
    -h|--help) sed -n '2,9p' "$0"; exit 0 ;;
    *) echo "Opção desconhecida: $1" >&2; exit 1 ;;
  esac
  shift
done

# Descobre a pasta de skills: repo local ou clone temporário (quando rodado via curl | bash)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"
if [[ -n "$SCRIPT_DIR" && -d "$SCRIPT_DIR/../skills" ]]; then
  SRC="$(cd "$SCRIPT_DIR/../skills" && pwd)"
else
  command -v git >/dev/null || { echo "git é necessário" >&2; exit 1; }
  TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
  git clone -q --depth 1 "$REPO_URL" "$TMP/repo"
  SRC="$TMP/repo/skills"
  [[ "$MODE" == "link" ]] && { echo "--link exige um clone local do repo" >&2; exit 1; }
fi

mapfile -t ALL < <(find "$SRC" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)
if [[ -n "$ONLY" ]]; then IFS=',' read -r -a SKILLS <<< "$ONLY"; else SKILLS=("${ALL[@]}"); fi

mkdir -p "$TARGET"
n=0
for s in "${SKILLS[@]}"; do
  [[ -d "$SRC/$s" ]] || { echo "⚠️  skill inexistente: $s" >&2; continue; }
  dest="$TARGET/$s"
  if [[ $UNINSTALL -eq 1 ]]; then
    # só remove se for skill deste arsenal (proteção contra apagar skill homônima de terceiros)
    if [[ -L "$dest" ]] || grep -q "^name: $s$" "$dest/SKILL.md" 2>/dev/null; then rm -rf "$dest"; n=$((n+1)); fi
    continue
  fi
  if [[ -e "$dest" && ! -L "$dest" ]] && ! cmp -s "$SRC/$s/SKILL.md" "$dest/SKILL.md"; then
    cp -r "$dest" "$dest.bak.$(date +%s)"   # backup de versão modificada localmente
  fi
  rm -rf "$dest"
  if [[ "$MODE" == "link" ]]; then ln -s "$SRC/$s" "$dest"; else cp -r "$SRC/$s" "$dest"; fi
  n=$((n+1))
done

if [[ $UNINSTALL -eq 1 ]]; then
  echo "✅ $n skills removidas de $TARGET"
else
  echo "✅ $n skills instaladas em $TARGET ($MODE)"
  echo "   Reinicie o Claude Code. Use /arsenal para o roteador ou /<skill> (ex.: /dockge)."
fi
