# テンプレート構成

テンプレート本体の最小構成（必須）:
- `README.md`
- `AGENTS.md`
- `AI_INSTRUCTIONS.md`
- `.github/workflows/template-check.yml`
- `scripts/check-template.sh`
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

生成後プロジェクトでは、上記のテンプレート本体専用ファイルを削除する。

推奨追加:
- `CONTRIBUTING.md`
