#!/usr/bin/env bash

set -u

pause_on_error() {
  printf '\nPress Enter to close.'
  read -r _
}

herdr_bin="${HERDR_BIN_PATH:-}"
if [[ -z "$herdr_bin" ]]; then
  herdr_bin="$(command -v herdr 2>/dev/null || true)"
fi

if [[ -z "$herdr_bin" || ! -x "$herdr_bin" ]]; then
  printf 'herdr URL picker: cannot locate the Herdr binary\n' >&2
  pause_on_error
  exit 1
fi

fzf_bin="${HERDR_FZF_PATH:-}"
if [[ -z "$fzf_bin" ]]; then
  fzf_bin="$(command -v fzf 2>/dev/null || true)"
fi
if [[ -z "$fzf_bin" ]]; then
  for candidate in \
    "$HOME/.local/bin/fzf" \
    "$HOME/.fzf/bin/fzf" \
    /home/linuxbrew/.linuxbrew/bin/fzf \
    /opt/homebrew/bin/fzf \
    /usr/local/bin/fzf \
    /usr/bin/fzf; do
    if [[ -x "$candidate" ]]; then
      fzf_bin="$candidate"
      break
    fi
  done
fi

if [[ -z "$fzf_bin" || ! -x "$fzf_bin" ]]; then
  printf 'herdr URL picker: fzf is required\n' >&2
  pause_on_error
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  printf 'herdr URL picker: python3 is required\n' >&2
  pause_on_error
  exit 1
fi

pane_id="${HERDR_ACTIVE_PANE_ID:-}"
if [[ -z "$pane_id" ]]; then
  pane_id="$("$herdr_bin" pane current --current 2>/dev/null | python3 -c '
import json, sys
data = json.load(sys.stdin)
pane = data.get("result", {}).get("pane", data.get("result", {}))
print(pane.get("pane_id", ""))
' 2>/dev/null)"
fi

if [[ -z "$pane_id" ]]; then
  printf 'herdr URL picker: could not determine the focused pane\n' >&2
  pause_on_error
  exit 1
fi

urls="$({ "$herdr_bin" pane read "$pane_id" --source visible --format text || true; } | python3 -c '
import re, sys

text = sys.stdin.read()
pattern = re.compile(r"(?:(?:https?|ftp|file)://[^\s<>\"\x27]+|www\.[^\s<>\"\x27]+)", re.I)
seen = set()
for match in pattern.findall(text):
    url = match.rstrip(".,;:!?)]}")
    if url.startswith("www."):
        url = "http://" + url
    if url and url not in seen:
        seen.add(url)
        print(url)
')"

if [[ -z "$urls" ]]; then
  printf 'No URLs found in the visible pane.\n'
  sleep 2
  exit 0
fi

selected="$(printf '%s\n' "$urls" | "$fzf_bin" --multi --exit-0 --no-preview --prompt='Open URL> ')"
[[ -z "$selected" ]] && exit 0

open_url() {
  local url="$1"

  if [[ -n "${HERDR_URL_OPENER:-}" ]]; then
    "$HERDR_URL_OPENER" "$url"
  elif [[ "$(uname -s)" == "Darwin" ]] && command -v open >/dev/null 2>&1; then
    open "$url"
  elif command -v wslview >/dev/null 2>&1; then
    wslview "$url"
  elif [[ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ]] && command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$url"
  elif [[ -n "${BROWSER:-}" ]] && command -v "$BROWSER" >/dev/null 2>&1; then
    "$BROWSER" "$url"
  else
    return 1
  fi
}

failed=()
while IFS= read -r url; do
  if ! open_url "$url" >/dev/null 2>&1; then
    failed+=("$url")
  fi
done <<<"$selected"

if (( ${#failed[@]} )); then
  # A headless SSH host cannot launch a browser on the client. Copy the first
  # selected URL through OSC 52 and leave clickable OSC 8 links in the popup.
  encoded="$(printf '%s' "${failed[0]}" | base64 | tr -d '\r\n')"
  printf '\033]52;c;%s\a' "$encoded"
  printf 'No graphical browser is available on this host.\n'
  printf 'Copied the first URL to the local clipboard:\n\n'
  for url in "${failed[@]}"; do
    printf '\033]8;;%s\033\\%s\033]8;;\033\\\n' "$url" "$url"
  done
  pause_on_error
fi
