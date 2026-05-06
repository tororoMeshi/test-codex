# 変更レポート（要件/設計見直し）

## 概要
- 発生日: 2026-05-06
- 対象機能/モジュール: `scripts/check-template.sh`, `scripts/smoke-test-generated.sh`
- 影響範囲: 生成後プロジェクトのテンプレート由来文言チェック
- 関係者: AI / 開発者

## 1. 何が想定外で起きたのか
- `generated` モードで、README の旧文言 `GitHub Template から生成したプロジェクトです` が残っていても検出できなかった。

## 2. 想定外が起きた原因
- 当該文言は `template` モードの README 誤記チェックにのみ含まれていた。
- `generated_forbidden_patterns` に含まれていなかったため、生成後プロジェクト側の置換漏れチェック対象から漏れていた。

## 3. 対応方法
- `generated_forbidden_patterns` に旧 README 文言を追加した。
- `check-template.sh` 自体が生成後チェックの走査対象になるため、スクリプト内の禁則語リテラルは既存方針と同じく文字列連結で保持した。
- `scripts/smoke-test-generated.sh` に、旧 README 文言が残る場合は `generated` チェックが失敗することを確認する失敗ケースを追加した。

## 4. 要件定義や設計で修正した部分
- `docs/template-checklist.md` の「README.md を実プロジェクトの説明に差し替えた」という項目を、自動チェックでも検出しやすくした。

## 補足（任意）
- 再発防止策: 生成後プロジェクトのスモークテストに成功ケースだけでなく、代表的な失敗ケースを含める。
- 検証:
  - `bash -n scripts/check-template.sh`
  - `bash -n scripts/smoke-test-generated.sh`
  - `bash scripts/check-template.sh template`
  - `bash scripts/smoke-test-generated.sh`
