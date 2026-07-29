#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if ! command -v exiftool >/dev/null 2>&1; then
  echo "exiftool is required. Install it with: brew install exiftool" >&2
  exit 1
fi

if [[ "$#" -eq 0 ]]; then
  echo "Usage: $0 <pdf-path> [pdf-path ...]" >&2
  exit 1
fi

pdf_count=0

process_pdf() {
  local pdf_path=$1
  local filename title

  if [[ ! -f "$pdf_path" ]]; then
    echo "PDF not found: $pdf_path" >&2
    exit 1
  fi

  if [[ ! "$pdf_path" =~ \.[Pp][Dd][Ff]$ ]]; then
    echo "Not a PDF file: $pdf_path" >&2
    exit 1
  fi

  filename=$(basename "$pdf_path")
  title=${filename%.[Pp][Dd][Ff]}
  pdf_count=$((pdf_count + 1))

  exiftool -overwrite_original -Title="$title" "$pdf_path" >/dev/null
  printf 'Set title: %s -> %s\n' "$pdf_path" "$title"
}

for pdf_path in "$@"; do
  process_pdf "$pdf_path"
done

if [[ "$pdf_count" -eq 0 ]]; then
  echo "No PDFs processed." >&2
fi
