#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${HOME}/.config"

mkdir -p "${CONFIG_DIR}"

for dir in "${SCRIPT_DIR}"/*; do
  [[ -d "${dir}" ]] || continue
  name="$(basename "${dir}")"

  case "${name}" in
    .git)
      continue
      ;;
  esac

  target="${CONFIG_DIR}/${name}"

  if [[ -e "${target}" && ! -L "${target}" ]]; then
    echo "Skipping ${name}; ${target} exists and is not a symlink" >&2
    continue
  fi

  ln -sfn "${dir}" "${target}"
  echo "Linked ${target} -> ${dir}"
done
