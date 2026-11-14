#!/usr/bin/env bash
# Rode na raiz de um projeto Git: conecta .cursor/rules, AGENTS.md e .agents/skills
# ao ~/ai-brain sem sujar o Git (entradas vão para .git/info/exclude).
set -euo pipefail
source "$(dirname "$0")/lib.sh"

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"
EXCLUDE="$(git rev-parse --git-path info/exclude)"
mkdir -p "$(dirname "$EXCLUDE")"; touch "$EXCLUDE"

exclude() { grep -qxF "$1" "$EXCLUDE" || echo "$1" >> "$EXCLUDE"; }

# .agents/skills -> ai-brain/skills
if ! is_link .agents/skills; then
  [ -e .agents/skills ] && { echo "ERRO: .agents/skills já existe e não é link; abortando." >&2; exit 1; }
  link_dir "$AI_BRAIN/skills" .agents/skills
fi
exclude "/.agents/skills"

# .cursor/rules/ai-brain.mdc (gerado da metodologia; arquivo não versionado)
mkdir -p .cursor/rules
{ printf -- '---\ndescription: Metodologia ai-brain\nalwaysApply: true\n---\n\n'
  cat "$AI_BRAIN/core/methodology.md"; } > .cursor/rules/ai-brain.mdc
exclude "/.cursor/rules/ai-brain.mdc"

# AGENTS.md: só cria se o projeto não tiver um próprio
if [ ! -e AGENTS.md ]; then
  cp "$AI_BRAIN/core/methodology.md" AGENTS.md
  exclude "/AGENTS.md"
elif ! git ls-files --error-unmatch AGENTS.md >/dev/null 2>&1 && grep -qxF "/AGENTS.md" "$EXCLUDE"; then
  cp "$AI_BRAIN/core/methodology.md" AGENTS.md   # nosso, atualiza
else
  echo "AGENTS.md do projeto mantido (versionado ou próprio)."
fi

echo "Projeto conectado: $ROOT"
git status --short -- .agents .cursor AGENTS.md
