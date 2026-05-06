# Project Intent

## 目的
- 生成AIがコード生成・修正時に迷わないよう、設計思想と運用方針の「本質」を固定化する
- 入口は短く強くし、詳細は責務ごとに分離して破綻しにくくする

## 設計思想（要約）
- Domain/Infra 分離を最優先し、依存方向を一方向に保つ
- 失敗しうる処理は `Result/Option` で扱い、`panic/unwrap/expect` は原則禁止
- YAGNI を厳守し、3か月以内の根拠がない先回り実装はしない
- 可観測性・再現性・セキュリティの最小ラインは最初から入れる
- ステートレスを基本とし、例外として DB/ローカルストレージへの保存を許可

## 運用方針（要約）
- 変更時はテストを最低1つ追加（例外規定は `docs/ai-architecture-rules.md`）
- 要件/設計の見直しが発生した場合は `docs/reports/` に変更レポートを残す
- The Twelve-Factor App は「参考思想」として設計判断の補助に使う

## AI 参照導線
- 自動参照用の入口: `AGENTS.md`
- 共通ルールの実体: `AI_INSTRUCTIONS.md`
- 詳細: `docs/ai-architecture-rules.md`, `docs/rust-coding-rules.md`
