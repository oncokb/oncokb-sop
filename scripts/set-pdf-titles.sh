#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
sop_dir="$script_dir/../static/sop"

if ! command -v exiftool >/dev/null 2>&1; then
  echo "exiftool is required. Install it with: brew install exiftool" >&2
  exit 1
fi

if [[ ! -d "$sop_dir" ]]; then
  echo "SOP directory not found: $sop_dir" >&2
  exit 1
fi

pdf_count=0

process_pdf() {
  local pdf_path=$1
  local filename title

  filename=$(basename "$pdf_path")
  title=${filename%.[Pp][Dd][Ff]}
  pdf_count=$((pdf_count + 1))

  exiftool -overwrite_original -Title="$title" "$pdf_path" >/dev/null
  printf 'Set title: %s -> %s\n' "$pdf_path" "$title"
}

while IFS= read -r -d '' pdf_path; do
  process_pdf "$pdf_path"
done < <(find "$sop_dir" -type f -iname '*.pdf' -print0)

if [[ "$pdf_count" -eq 0 ]]; then
  echo "No PDFs found." >&2
fi
