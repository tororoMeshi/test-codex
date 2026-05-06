#!/usr/bin/env bash
set -euo pipefail

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT
repo_root="$(pwd)"

prepare_generated_project() {
  local project_dir="$1"

  cp -a "$repo_root/." "$project_dir"

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

if (cd "$failure_project" && bash scripts/check-template.sh generated); then
  echo "generated check should fail when old generated README text remains"
  exit 1
fi
