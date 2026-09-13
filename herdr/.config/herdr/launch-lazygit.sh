#!/usr/bin/env bash

set -u

lazygit_bin="${HERDR_LAZYGIT_PATH:-}"
if [[ -z "$lazygit_bin" ]]; then
  lazygit_bin="$(command -v lazygit 2>/dev/null || true)"
fi
if [[ -z "$lazygit_bin" ]]; then
  for candidate in \
    "$HOME/.local/bin/lazygit" \
    /home/linuxbrew/.linuxbrew/bin/lazygit \
    /opt/homebrew/bin/lazygit \
    /usr/local/bin/lazygit \
    /usr/bin/lazygit; do
    if [[ -x "$candidate" ]]; then
      lazygit_bin="$candidate"
      break
    fi
  done
fi

if [[ -z "$lazygit_bin" || ! -x "$lazygit_bin" ]]; then
  printf 'Herdr: lazygit is installed but was not found in a known location.\n' >&2
  printf 'Set HERDR_LAZYGIT_PATH to its absolute path.\n\n' >&2
  printf 'Press Enter to close.'
  read -r _
  exit 1
fi

exec "$lazygit_bin"
