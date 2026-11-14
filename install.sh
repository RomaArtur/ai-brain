#!/usr/bin/env bash
# Conecta ~/ai-brain ao Claude Code e ao Antigravity. Idempotente: pode rodar de novo.
# Cada skill vira um link individual em ~/.claude/skills, preservando a pasta
# "synced/" que o app do Claude gerencia.
set -euo pipefail
source "$(dirname "$0")/lib.sh"

SRC="$AI_BRAIN/skills"
CLAUDE_SKILLS="$HOME/.claude/skills"
BACKUP="$HOME/.claude/skills.backup"

# 1. Backup único (não sobrescreve um backup existente)
if [ -d "$CLAUDE_SKILLS" ] && [ ! -e "$BACKUP" ]; then
  echo "Backup: $CLAUDE_SKILLS -> $BACKUP"
  cp -r "$CLAUDE_SKILLS" "$BACKUP"
fi
mkdir -p "$CLAUDE_SKILLS"

# 2. Link por skill em ~/.claude/skills
for dir in "$SRC"/*/; do
  name="$(basename "$dir")"
  dest="$CLAUDE_SKILLS/$name"
  if is_link "$dest"; then continue; fi
  if [ -e "$dest" ]; then
    if diff -rq "$dir" "$dest" >/dev/null; then
      rm -rf "$dest"            # idêntica à do ai-brain (e já no backup)
    else
      echo "AVISO: $dest difere do ai-brain; mantido. Resolva à mão." >&2; continue
    fi
  fi
  link_dir "${dir%/}" "$dest" && echo "link: $name"
done

# 3. Antigravity / .agents: link da pasta inteira
for target in "$HOME/.gemini/antigravity/skills" "$HOME/.agents/skills"; do
  parent="$(dirname "$target")"
  # .gemini/antigravity só se o Antigravity estiver instalado; .agents só se existir
  [ -d "$parent" ] || continue
  if is_link "$target"; then continue; fi
  if [ -e "$target" ]; then
    mv "$target" "$target.backup.$(date +%Y%m%d%H%M%S)"
  fi
  link_dir "$SRC" "$target" && echo "link: $target"
done

# 4. ~/.claude/CLAUDE.md importa a metodologia
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
IMPORT="@~/ai-brain/core/methodology.md"
touch "$CLAUDE_MD"
grep -qxF "$IMPORT" "$CLAUDE_MD" || { printf '\n%s\n' "$IMPORT" >> "$CLAUDE_MD"; echo "CLAUDE.md: import adicionado"; }

echo "Pronto."
