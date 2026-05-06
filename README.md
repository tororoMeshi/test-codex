# AI Coding Project Template

このリポジトリは、AIコード生成を前提にしたプロジェクト用 GitHub Template です。

生成後のプロジェクトでは、`docs/template-checklist.md` に従って、
README、LICENSE、プロジェクト名などを実プロジェクト向けに差し替えてください。

## テンプレート利用の要点
- `AGENTS.md`, `AI_INSTRUCTIONS.md`, `docs/` はテンプレート必須
- AI向け共通ルールの実体は `AI_INSTRUCTIONS.md` に集約
- Codex など自動参照に対応するAIツール向けには `AGENTS.md` から誘導
- 変更レポートは `docs/reports/` に保存（命名は `YYYY-MM-DD_<short-topic>_change.md`）
- テンプレート本体の健全性チェックは `scripts/check-template.sh template` で実行
- 生成後プロジェクトの置換漏れチェックは `scripts/check-template.sh generated` で実行
- 生成後チェックのスモークテストは `scripts/smoke-test-generated.sh` で実行

## ローカル検証
`scripts/smoke-test-generated.sh` は、Git管理下の現在の作業ツリーを使って生成後プロジェクト相当の検査を行います。
コミット済みファイルに加えて追跡済みの未コミット変更は検証対象に含め、未追跡ファイルは含めません。

## テンプレート運用（更新の反映）
テンプレート本体の更新は `CONTRIBUTING.md` を参照してください。

## チェックリスト
テンプレート利用時のチェックは `docs/template-checklist.md` を参照してください。

## テンプレート構成
構成の詳細は `docs/template-structure.md` を参照してください。
