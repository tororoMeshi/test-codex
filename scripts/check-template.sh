#!/usr/bin/env bash
set -euo pipefail

mode="${1:-template}"

common_required_files=(
  "README.md"
  "AGENTS.md"
  "AI_INSTRUCTIONS.md"
  "docs/project-intent.md"
  "docs/ai-architecture-rules.md"
  "docs/rust-coding-rules.md"
  "docs/change-report-template.md"
)

template_required_files=(
  ".github/workflows/template-check.yml"
  "scripts/check-template.sh"
  "docs/template-checklist.md"
  "docs/template-structure.md"
)

required_dirs=(
  "docs/reports"
)

check_required_files() {
  local file

  for file in "$@"; do
    if [ ! -f "$file" ]; then
      echo "missing required file: $file"
      exit 1
    fi
  done
}

check_required_dirs() {
  local dir

  for dir in "$@"; do
    if [ ! -d "$dir" ]; then
      echo "missing required directory: $dir"
      exit 1
    fi
  done
}

check_required_files "${common_required_files[@]}"
check_required_dirs "${required_dirs[@]}"

case "$mode" in
  template|generated)
    ;;
  *)
    echo "unknown mode: $mode"
    echo "usage: $0 [template|generated]"
    exit 1
    ;;
esac

if [ "$mode" = "template" ]; then
  check_required_files "${template_required_files[@]}"
fi

case "$mode" in
  template)
    if grep -q "GitHub Template から生成したプロジェクトです" README.md; then
      echo "README.md still describes this repository as a generated project"
      exit 1
    fi
    ;;
  generated)
    generated_forbidden_files=(
      "docs/template-checklist.md"
      "docs/template-structure.md"
    )

    for file in "${generated_forbidden_files[@]}"; do
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
      "AI Coding Project ""Template"
      "GitHub Template ""として利用する前提"
      "GitHub Template ""です"
      "テンプレート""本体"
      "テンプレート利用""チェックリスト"
      "テンプレート""構成"
      "test-""codex"
      "<project-""name>"
    )

    for pattern in "${generated_forbidden_patterns[@]}"; do
      if [ -z "$pattern" ]; then
        continue
      fi

      if find . \
        -path './.git' -prune -o \
        -path './node_modules' -prune -o \
        -path './target' -prune -o \
        -path './dist' -prune -o \
        -path './build' -prune -o \
        -type f \
        ! -name '*.png' \
        ! -name '*.jpg' \
        ! -name '*.jpeg' \
        ! -name '*.gif' \
        ! -name '*.webp' \
        ! -name '*.pdf' \
        -print0 \
        | xargs -0 grep -nI -- "$pattern"; then
        echo "generated project still contains template text: $pattern"
        exit 1
      fi
    done
    ;;
esac

echo "$mode check passed"
