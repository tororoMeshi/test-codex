# AGENTS.md

このリポジトリのAI向け共通ルールは `AI_INSTRUCTIONS.md` に集約しています。
作業前に必ず `AI_INSTRUCTIONS.md` を読んでください。

## 最重要ルール

- panic / unwrap / expect を原則禁止する
- Domain層に HTTP / DB / Queue / Cloud SDK などのインフラ依存を持ち込まない
- YAGNI を守り、根拠のない将来対応を入れない
- 変更時は、必要に応じてテストまたは検証方法を明記する
- 変更レポートは `docs/reports/` に保存する

詳細は `AI_INSTRUCTIONS.md` と `docs/` 配下を参照してください。
