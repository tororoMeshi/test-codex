# AI Instructions (General)

このリポジトリのコード生成・修正では、以下を**必ず**守ること。

## 最優先ルール（破ったらNG）
1. **panic / unwrap / expect を原則禁止**。失敗しうる処理は `Result/Option` と `?` を使う。  
2. **Domain層にインフラ依存を持ち込まない**（HTTP/DB/Queue/Cloud SDK 等の型・概念を domain に入れない）。  
3. **YAGNI**：3か月以内に確実な根拠がない“将来対応”の実装（過剰な抽象化・先回り分割・高性能化）は入れない。  
4. **可観測性・再現性・セキュリティの最小ライン**は最初から入れる（例: JSONログ、request_id/trace_id、設定とSecretの分離）。  
5. 変更時は、**テストを最低1つ追加**（ユニット or 統合）。※例外規定は `docs/ai-architecture-rules.md` に従う。
6. **ステートレスを基本**とする（例外としてDBやローカルストレージへの保存は許可）。

## 参照すべき詳細ルール
- Rustコーディング規約（安全・エラーハンドリング）: `docs/rust-coding-rules.md`
- 設計・運用・YAGNI・テスト戦略（AI生成規約）: `docs/ai-architecture-rules.md`
- 変更レポートテンプレート: `docs/change-report-template.md`
- プロジェクト目的・設計思想の要約: `docs/project-intent.md`

## 優先順位（衝突時）
`rust-coding-rules`（安全・エラー） > `ai-architecture-rules`（設計・運用） > 実装の都合

## 例外規定（要約）
- テスト追加が不要な例外: ドキュメント変更、リネームのみ、CI設定変更など（詳細は `docs/ai-architecture-rules.md`）。
