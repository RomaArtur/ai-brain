#!/usr/bin/env bash
# Funções compartilhadas por install.sh e link-project.sh

AI_BRAIN="${AI_BRAIN:-$HOME/ai-brain}"

is_windows() { case "$(uname -s)" in MINGW*|MSYS*|CYGWIN*) return 0;; *) return 1;; esac; }

# link_dir ALVO LINK  -> cria link de pasta (symlink; no Windows cai para junction)
link_dir() {
  local target="$1" link="$2"
  mkdir -p "$(dirname "$link")"
  if is_windows; then
    MSYS=winsymlinks:nativestrict ln -s "$target" "$link" 2>/dev/null && return 0
    cmd //c mklink //J "$(cygpath -w "$link")" "$(cygpath -w "$target")" >/dev/null
  else
    ln -s "$target" "$link"
  fi
}

# is_link CAMINHO -> verdadeiro para symlink ou junction
is_link() {
  [ -L "$1" ] && return 0
  is_windows && [ -d "$1" ] && fsutil reparsepoint query "$(cygpath -w "$1")" >/dev/null 2>&1
}

# unlink_dir CAMINHO -> remove só o link, nunca o conteúdo do alvo
unlink_dir() {
  if is_windows && ! [ -L "$1" ]; then cmd //c rmdir "$(cygpath -w "$1")"; else rm "$1"; fi
}
