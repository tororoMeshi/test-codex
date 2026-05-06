# テンプレート利用チェックリスト

## 必須
- `README.md` が存在し、テンプレート利用方針への導線がある
- `AGENTS.md` が存在し、`AI_INSTRUCTIONS.md` へ誘導している
- `AI_INSTRUCTIONS.md` が存在し、共通ルールの実体として参照されている
- `.github/workflows/template-check.yml` が存在し、テンプレート検査を実行する
- `scripts/check-template.sh` が存在する
- `docs/project-intent.md` が存在し、プロジェクト目的・設計思想の要約として参照されている
- `docs/ai-architecture-rules.md` が存在する
- `docs/rust-coding-rules.md` が存在する
- `docs/change-report-template.md` が存在する
- `docs/reports/` が存在する

## テンプレート生成後
- [ ] README.md を実プロジェクトの説明に差し替えた
- [ ] Markdown にテンプレート本体向けの説明が残っていない
- [ ] Markdown に危険なプレースホルダー（例: `<project-name>`）が残っていない
- [ ] `docs/template-checklist.md` を削除した
- [ ] `docs/template-structure.md` を削除した
- [ ] 実プロジェクト用に同種の文書が必要な場合は、`docs/project-checklist.md` や `docs/project-structure.md` など別名で作成した
- [ ] テンプレート由来の `docs/reports/*.md` を削除し、`docs/reports/` 自体は残した
- [ ] 派生プロジェクトとして公開する場合、LICENSE の著作権者を必要に応じて変更した

## 自動チェック
- [ ] テンプレート本体では `scripts/check-template.sh template` が成功する
- [ ] 生成後プロジェクトでは `scripts/check-template.sh generated` が成功する
- [ ] GitHub Actions では、GitHub API の `is_template` により、テンプレート本体は `template`、生成後プロジェクトは `generated` として検査される

## 推奨
- `CONTRIBUTING.md` にテンプレート更新の反映方針が記載されている
- The Twelve-Factor App が「参考思想」として明記されている
- 変更レポートの保存先と命名規則が明記されている
