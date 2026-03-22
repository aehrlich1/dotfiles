#!/usr/bin/env bash
set -euo pipefail

FISH_BIN="$(command -v fish || true)"

if [[ -z "${FISH_BIN}" ]]; then
  echo "Error: fish shell is not installed. Please install fish first." >&2
  exit 1
fi

CURRENT_SHELL="${SHELL:-}"

if [[ "${CURRENT_SHELL}" == "${FISH_BIN}" ]]; then
  echo "Fish is already the default login shell (${FISH_BIN})."
  exit 0
fi

echo "Setting default shell to ${FISH_BIN}..."
chsh -s "${FISH_BIN}"
echo "Shell changed. You may need to log out and back in for it to take effect."
