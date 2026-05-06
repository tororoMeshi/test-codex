#!/usr/bin/env bash
set -euo pipefail

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

cp -a . "$tmpdir/project"
cd "$tmpdir/project"

rm -f docs/template-checklist.md
rm -f docs/template-structure.md
rm -f scripts/smoke-test-generated.sh
rm -f docs/reports/*.md

cat > README.md <<'EOF'
# Sample Generated Project

This is a generated project used for template check smoke testing.
EOF

cat > CONTRIBUTING.md <<'EOF'
# Contributing

このプロジェクトの変更方針を記載します。
EOF

bash scripts/check-template.sh generated
