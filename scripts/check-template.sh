#!/usr/bin/env bash
set -euo pipefail

required_files=(
  "AGENTS.md"
  "AI_INSTRUCTIONS.md"
  "docs/ai-architecture-rules.md"
  "docs/rust-coding-rules.md"
  "docs/change-report-template.md"
  "docs/reports/.gitkeep"
)

for file in "${required_files[@]}"; do
  if [ ! -e "$file" ]; then
    echo "missing required file: $file"
    exit 1
  fi
done

if grep -q "GitHub Template から生成したプロジェクトです" README.md; then
  echo "README.md still describes this repository as a generated project"
  exit 1
fi

if grep -q "<project-name>" README.md; then
  echo "README.md still contains <project-name>; use PROJECT_NAME or replace it"
  exit 1
fi

echo "template check passed"
