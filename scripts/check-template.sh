#!/usr/bin/env bash
set -euo pipefail

mode="${1:-template}"

required_files=(
  "README.md"
  "AGENTS.md"
  "AI_INSTRUCTIONS.md"
  ".github/workflows/template-check.yml"
  "scripts/check-template.sh"
  "docs/project-intent.md"
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
    template_only_files=(
      "docs/template-checklist.md"
      "docs/template-structure.md"
    )

    for file in "${template_only_files[@]}"; do
      if [ -e "$file" ]; then
        echo "template-only file remains in generated project: $file"
        exit 1
      fi
    done

    if find docs/reports -maxdepth 1 -type f \( -name 'template-*.md' -o -name '*_template-*.md' \) | grep -q .; then
      echo "template-origin reports remain in docs/reports/"
      exit 1
    fi

    generated_forbidden_patterns=(
      "AI Coding Project Template"
      "GitHub Template として利用する前提"
      "GitHub Template です"
      "テンプレート本体"
      "テンプレート利用チェックリスト"
      "テンプレート構成"
      "test-codex"
      "<project-name>"
    )

    for pattern in "${generated_forbidden_patterns[@]}"; do
      if git grep -n "$pattern" -- '*.md'; then
        echo "generated project still contains template text: $pattern"
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
