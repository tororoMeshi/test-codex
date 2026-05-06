# テンプレート構成

テンプレート本体の最小構成（必須）:
- `README.md`
- `AGENTS.md`
- `AI_INSTRUCTIONS.md`
- `.github/workflows/template-check.yml`
- `scripts/check-template.sh`
- `scripts/smoke-test-generated.sh`
- `docs/project-intent.md`
- `docs/template-checklist.md`
- `docs/template-structure.md`
- `docs/ai-architecture-rules.md`
- `docs/rust-coding-rules.md`
- `docs/change-report-template.md`
- `docs/reports/`

テンプレート本体専用:
- `docs/template-checklist.md`
- `docs/template-structure.md`
- `scripts/smoke-test-generated.sh`

生成後プロジェクトでは、上記のテンプレート本体専用ファイルを削除する。

生成後プロジェクトにも残す品質ゲート:
- `.github/workflows/template-check.yml`
- `scripts/check-template.sh`

推奨追加:
- `CONTRIBUTING.md`
