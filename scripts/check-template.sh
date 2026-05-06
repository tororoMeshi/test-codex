#!/usr/bin/env bash
set -euo pipefail

mode="${1:-template}"

required_files=(
  "README.md"
  "AGENTS.md"
  "AI_INSTRUCTIONS.md"
  "docs/ai-architecture-rules.md"
  "docs/rust-coding-rules.md"
  "docs/change-report-template.md"
)

required_dirs=(
  "docs/reports"
)

for file in "${required_files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "missing required file: $file"
    exit 1
  fi
done

for dir in "${required_dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "missing required directory: $dir"
    exit 1
  fi
done

case "$mode" in
  template)
    if grep -q "GitHub Template から生成したプロジェクトです" README.md; then
      echo "README.md still describes this repository as a generated project"
      exit 1
    fi
    ;;
  generated)
    forbidden_patterns=(
      "AI Coding Project Template"
      "GitHub Template として利用する前提の雛形です"
      "GitHub Template です"
      "<project-name>"
    )

    for pattern in "${forbidden_patterns[@]}"; do
      if grep -q "$pattern" README.md; then
        echo "README.md still contains template text: $pattern"
        exit 1
      fi
    done
    ;;
  *)
    echo "unknown mode: $mode"
    echo "usage: $0 [template|generated]"
    exit 1
    ;;
esac

echo "$mode check passed"
