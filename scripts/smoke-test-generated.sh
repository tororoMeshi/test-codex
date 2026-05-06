#!/usr/bin/env bash
set -euo pipefail

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT
repo_root="$(git rev-parse --show-toplevel)"

copy_tracked_worktree() {
  local project_dir="$1"

  (
    cd "$repo_root"
    git ls-files -z | tar --null --ignore-failed-read -T - -cf -
  ) | tar -xf - -C "$project_dir"
}

prepare_generated_project() {
  local project_dir="$1"

  mkdir -p "$project_dir"

  # Copy tracked worktree files so local edits are tested without mixing in
  # untracked files such as build output or editor scratch files.
  copy_tracked_worktree "$project_dir"

  rm -f "$project_dir/docs/template-checklist.md"
  rm -f "$project_dir/docs/template-structure.md"
  rm -f "$project_dir/scripts/smoke-test-generated.sh"
  rm -f "$project_dir"/docs/reports/*.md

  cat > "$project_dir/CONTRIBUTING.md" <<'EOF'
# Contributing

このプロジェクトの変更方針を記載します。
EOF
}

success_project="$tmpdir/success-project"
prepare_generated_project "$success_project"

cat > "$success_project/README.md" <<'EOF'
# Sample Generated Project

This is a generated project used for template check smoke testing.
EOF

(cd "$success_project" && bash scripts/check-template.sh generated)

failure_project="$tmpdir/failure-project"
prepare_generated_project "$failure_project"

cat > "$failure_project/README.md" <<'EOF'
# Sample Generated Project

GitHub Template から生成したプロジェクトです
EOF

set +e
output="$(cd "$failure_project" && bash scripts/check-template.sh generated 2>&1)"
status=$?
set -e

if [ "$status" -eq 0 ]; then
  echo "generated check should fail when old generated README text remains"
  exit 1
fi

if ! printf '%s\n' "$output" | grep -q "generated project still contains template text"; then
  echo "generated check failed, but not for the expected reason"
  printf '%s\n' "$output"
  exit 1
fi

if ! printf '%s\n' "$output" | grep -q "GitHub Template から生成したプロジェクトです"; then
  echo "generated check did not report the expected forbidden text"
  printf '%s\n' "$output"
  exit 1
fi
